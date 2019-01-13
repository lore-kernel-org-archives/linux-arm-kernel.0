Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4EF20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cVW9gWqz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gj9B9jbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4EF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jhf5x/jNyaKT50KDZKY3M8OJk5zZHUGe92j9KKFBIVA=; b=cVW9gWqz4JJoMb
	A8oRGuiLhELBWhqNePQt71oBcehJnLEd+oD2ubdjm48lX9EzJ/W2Y79WUdpFfFqHzSic9ibKylq7I
	9rOGNioXCPLbyPQmRNGf+fBh7g8t0V16AUla6rhcXu0AqW0MpzdJdxjloQoHQKTzNUmjMFgXzpWde
	WpHKnB3cvYQvUw3+IwyphCZ4pumGRstdXkhq260kNlxTW0IgMCnNnIF9tq9edJYJ4jNUR9aAcxfjt
	vm5E8W0IgB/oG9GJMOqY0Ek8LqFIF/isTQY7UkvqndGnJ9qsbFYb0beVelA0Daiz+eLAgykdYI1WV
	DXslpIfFRBYxNwxT7egQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giZ0K-0004nS-Js; Sun, 13 Jan 2019 06:12:16 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYz4-0003ea-85
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:11:03 +0000
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so16233503ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IuVgmQY5YHFZsHMstj0yV8SSCQh9h650tOF9s1W+U6c=;
 b=gj9B9jbT2q8xCjFPuEn8YE5F8vWWTIw2zIJJsOocWhL1CmtpAaduzJrJ5UEEU6QeCN
 WYCVEW5rN307JLO/cHR0XBuSjqZC0hBDnbDUQZErsUczwWU2Vaf5Hcvj/fMvfAwqTThS
 Jk3kPzBphZrhTyTJNi4KETfxZ9zmDVjlAAsS/PL7IWnPfiw2WSbSxuGhXTeHrYK2C052
 ywxrrR2dz+8J5j4jYH4ewe9lkOHM0h+Iwpo2wi0qF9ZjdC1iGdKdGPtIcvb/Hcl6HKdu
 dZQZgcyrljbgLuozQ2qJEVQXr5v0qoI0Q36Gq+IQnhgwf/DCOwWwOu79J5oiGhFdORiL
 +31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IuVgmQY5YHFZsHMstj0yV8SSCQh9h650tOF9s1W+U6c=;
 b=bb4MzYlYbmMigz9lhbUemk9VG4/lsSKFAVRAOGJzLLP06inejb4YEU2mrPCzNnLNo+
 r5FlpRZZXTyJANA41yPr+g2ltbsOLwhWSDPgbbVJCOh+vT2TKmp8EKjyQZ0KzEm8SZ/a
 LDwK/D3us3FRTdM3Cdg6hE/V3Vo/5OiYE58nzRawHsQnj2CPZ2EBaYb40aRaCxCJrJPs
 04wEjKy/2QILqZFbYWUw1PBN0DU1pKOzEjlvkpwj9mVrrsW0bQfCgivVEeJMF5xcN0IA
 hFZ0Ya6gTYvvwp+afqsHNdmkDtuNtvqGXZufb1ygJky7anR96ZsQBW8LxZ+02uKgkNPy
 RVeg==
X-Gm-Message-State: AJcUukd8ojXI6jj+1LxmfUSfvRDrISqs4/DBTJ3dzcjRT2dxaCWYPqSh
 Y1UqLvUdpqQ8TeyjkLCLZOb2Bg==
X-Google-Smtp-Source: ALg8bN5Ax1SiowT0HxmPl5v+n5ZZXV2Q2D6U4Xo1kQuJg1zlhzj+PnCpCa4+t1xyfZx2hKu9fZg4TQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id
 p16-v6mr3224159ljj.102.1547359855259; 
 Sat, 12 Jan 2019 22:10:55 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f20-v6sm16629467ljk.33.2019.01.12.22.10.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:53 -0800 (PST)
Date: Sat, 12 Jan 2019 22:06:35 -0800
From: Olof Johansson <olof@lixom.net>
To: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC, GIT PULL] Late reset controller changes for v5.0
Message-ID: <20190113060635.7lhatlwwhxedk6d3@localhost>
References: <1546966907.5406.17.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546966907.5406.17.camel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221059_085696_A904CA13 
X-CRM114-Status: GOOD (  14.63  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kernel@pengutronix.de, Dinh Nguyen <dinguyen@kernel.org>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 06:01:47PM +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> due to a combination of a late merge conflict, early holidays, and the
> common cold, I have failed to send the last reset controller pull
> request in time for the v5.0-rc1 merge window. As usual there are not
> many changes, and they have been carried in linux-next for quite a
> while.
> 
> One of the changes, commit b3ca9888f35f ("reset: socfpga: add an early
> reset driver for SoCFPGA") is necessary for the Stratix10 platform to
> boot, since the already merged change 8bb4f3f55961 ("arm64: dts:
> stratix10: use "altr,stratix10-rst-mgr" binding") depends on it.
> 
> Can you take the whole lot for v5.0-rc2? Should I split out the SoCFPGA
> early reset patch + the NULL pointer dereference fix into a separate
> "fixes" pull request for v5.0-rc2, postponing the other patches to for-
> v5.1? Or do we have to revert 8bb4f3f55961 for now? Please advise.

Hi,

Unfortunate, but looking at the set of patches, it's also not a whole lot of
code. Based on the list, nothing looks particularly high risk.

I've merged the lot into our fixes branch.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

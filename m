Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:31:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89B62145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHy+65fu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgHo/1Mv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V+m3djvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89B62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G6+CGdAmyYraVHSIPrcehhKewJuYh/yQ4mRv+bzNuvA=; b=KHy+65furn0wQ7
	aLXiImjM4tFlLwM275qMRxu0Kd+2xzPCh1Wri7tjQdAaJi0w3MGyqhxjuc0jhD03dCB8/Zz95IFw1
	Fj2IPrHDrfB+zS94fPAQF7QgMRjQte05ySHGr5n4I2C+3J1mW7V/EfaBNgIPijsuHNAaBegF7U2Mt
	iU6HqjxjpsTDLy21yZTHFonraRebEuuFRccqFY4v1klnWjW/V7ZJdkydrKfcbk1lO0OlcBlM5394I
	8BXpKSXXh3GnPnvxxKr+5JAqob/jdfzbQVRQ+1pth9o3mwl8HKon/KZD57z+yXPMxb4Tz3LvubxOH
	hVfRQqLoCf7KA70s4tqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStCB-0003ec-E6; Sat, 01 Dec 2018 00:31:43 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStBt-0003QZ-Ko
 for linux-arm-kernel@bombadil.infradead.org; Sat, 01 Dec 2018 00:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DzZrpkj9SH92CVO4vfiT66aL5a4djCSa5PWRrqMJ5bM=; b=DgHo/1Mv6tp9FeXKqg6hn5aiT
 rWG0CZFHw2h7KcmMkTL4Ax0/g2h2+8WZ3P8Ztuag5/QUzBHsPv651t6djf/d7+BTgJ7eogl06P5bd
 vGRohTyCs6RKmpsCH7Y5drOJHDhaK4jdjN5Akc9HMNaEkJ5jwvHVcHSvvoXWVKsRAKMezEXQVEONP
 KJ3tdagKJiGYqY5HirAnB+3Ext1gzCjLa8eCD1sFnjVKQWyl72KEjXyH3ot0pd48ROg0UmcSnXZ4a
 hvUmgkzMx60MyYqX3gGe8apfIeeK+z3/bWW3mt/+VgHnxFP/nIZuiZo5dLstPSAErCSboTLSdF6q0
 plqp0vkIg==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSshz-0008IK-Kb
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:00:32 +0000
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so6498840ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DzZrpkj9SH92CVO4vfiT66aL5a4djCSa5PWRrqMJ5bM=;
 b=V+m3djvobi4ISBeMIDH5i14yQZadnsKpppHy5V9tFR3q9DAIO8dLw0hx0DgUAlBnuH
 ObnDD2JHVBOonbyp5jRaO0yshfPgnjgDlCyDX1flkLr9vA/0K0XIecqtOunPPCvEivzH
 zfcQeLbOqSaPJFls1L2aMO0HvShJlai9Pk9Iel4tMpGNTJbKV1UgqgKatFW7RKYrar71
 yL43cipjC0hIPy8bPh1v9d4NUB9rVb/81l4NQjDH2HNTGmOVhnl/exvQd+R2fH0iZCLZ
 xsQxpcatSMdJ2Wb1u8GAQnReam006kqbjWfNS3jHoccvSLdGHaPbY+x2qOEgz1Oig5O/
 nACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DzZrpkj9SH92CVO4vfiT66aL5a4djCSa5PWRrqMJ5bM=;
 b=SiTWJMYrPAZNQ36mUzvjxrEIj8XBnCF0iXJBB+qNBxvS4U3wdZ+aNL5dPhO3hbRLdH
 1GeSVI31mhHhd7bFnmDGAMpe2LDgR+MzSoG7UQa5LB/dVkfQjQPJT+f8LAwMGS97tIkM
 iTwTED5ipQLRMpU/LaPqyFDDb9dN+bWAI1uy8AjEz0j0UlUNXMe80ZltD6M+cnZMfh0M
 9KBQwLB3eqZ93nUvro3XR6oMdOytg0yYjDNw+q9DgzbpB16cTtVMpoZPp/tAaY7jkfwi
 LDtpyp1qEqt9QXdFn55ZGbdE6+/pBfhQ8ceEu5uirx8N2XqHUoH8OeB05TukNANgp04F
 5bHg==
X-Gm-Message-State: AA+aEWZdgBLnbPIq50LNaQLRg0DeDEiWpb9YVFk7ioPLqifYWe905b7J
 +3rtJ9z273Qv/J5q2XSh5RwYqg==
X-Google-Smtp-Source: AFSGD/X/ljl9IQkMxzl8Uu423qdCmOEBzAyLIchlatcmeNsrvNMGPkMis0sFrzm4eydGMM8zQ/QQAg==
X-Received: by 2002:a2e:8ec8:: with SMTP id
 e8-v6mr5054280ljl.162.1543622419567; 
 Fri, 30 Nov 2018 16:00:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d75sm1165327lfe.0.2018.11.30.16.00.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 16:00:18 -0800 (PST)
Date: Fri, 30 Nov 2018 15:59:38 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 16/20] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20181130235938.zcxljgb4babgjflj@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-17-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-17-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_190031_710402_047ED9D7 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:20PM +0100, Lubomir Rintel wrote:
> The device-tree booted MMP2 needs to enable the timer clock, otherwise
> it would stop ticking when the boot finishes.
> 
> It can also use the clock rate from the clk, the non-DT boards need to
> keep using the hardcoded rates.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied to next/soc, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

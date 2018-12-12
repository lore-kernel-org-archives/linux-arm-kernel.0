Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:32:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1968020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9kdnSdf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZyK2ekaR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Iwd5NtL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IaL+I7A0vXjG6L2iTBf3oP+hhruMzqZF+M/CdlB81zU=; b=N9kdnSdf0u6m54
	QGr0cdjanSFf/AccYZF/sOrWU7VmHITNzu4+Ia9cmHtb2WQsjOMqtW9uzgxWWj4VIq4sekkypB3HO
	wDpBdA02oFmTUKexY8mZNXmggyAc55GP0vErygeNr5kavNhBml8MIoM85njIqRpNkshuq6q344+go
	Kfmv3iPKDXOiolOsZYxiVJ2c+4xkdyNw4kcm1EsV6MnNl4hmd2CJ5NLOc06pGHG7QuFSbKu43qYL5
	1aVo5md/QXoRleCbOFs/QtQItM5XXR14t0TR0Xhe5jq8ILoBWCsS/a216+SOWYZV7XZLBSjo+byzj
	jBZFxCSx91J5fwv3FW8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD3k-0003fJ-53; Wed, 12 Dec 2018 22:32:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXD3S-00036T-Mg
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 22:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jWeox1QMSA1rcqXOTQM7uLfM3BrUU26ONRQE87Mb9QM=; b=ZyK2ekaRClXtOqQkLs7Oc4dsA
 z7j2pzwS7QSQVCIa+Msn+BDNrdcFIc2PFQ+35lW8oPsok4PmV4F0leJbiq3QLZ9s7qZSWaFj82O7+
 fvvOYJRTZlL6WGrS/KGAslnlEiPh1n7B2LKKgyJCiaKHSOXVMbh02YHEM6BXPUpg4OLWp1p7JQyI/
 NjgCvVcg9wKpydUDc4MuH+i0O400JVnm9k7wt/pIoRHLp+3JSC93qgufDHI5gwO33neZrj6Rt2m52
 duQdot9/Q8PNurFOxRIDBqu1m1iFqxzmOdPVWaMep0jKDNGn6AMLjxaAFqdXR1Ur3xTQOuKyulRQE
 DEcOEFxcw==;
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCns-0003wc-0X
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:29 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so14735994lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jWeox1QMSA1rcqXOTQM7uLfM3BrUU26ONRQE87Mb9QM=;
 b=Iwd5NtL4tzqyo6Uf2eM6TUt0YB2OGnZ6tcxKGGbUkBdZXFb71sDaGWOvJ2dwjLfUSS
 5cCiDME2/jHzsfYGek/qsdBdtR+NIiQqgh1kEfAABwy2L3edcFL0Qgn0SaLkTXoRsTZZ
 r0k3B1mMFaXUttZTOykPNHiGd8QOkG9tYSFzcuVSMOHWpYDs9nrbmWzYwQ78bJxefQXX
 sFkuAPxt1d6Rlf1ISedzvBglCPJhGbDxtRpgYi2mNZ0vYqvelg95Jl1jPO8m0T3VZ+o8
 mwFwQvRBPn16jwtGZ5bNtqhDPFoXWDgmXWU/6VN0oDbW+LpyP79NeHlXOJNnke6F5LA9
 tCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jWeox1QMSA1rcqXOTQM7uLfM3BrUU26ONRQE87Mb9QM=;
 b=EFzFbBRIkukcVqtkxrkmxPb653kYinV2iGG5LMDgt1vbLGWYBu5Ec/ZgO9XStTUzWS
 9yx4BTHyf+JNJCB8UY6TKhQx0EyChzbwvXiJq739HF7BQYHbX6A5P4MjIxSYhgmRtmMa
 +JH7LSyK2jEEppP24ssQ8CZ2JM0iCU8wM+1CsYZcvYlXVcQgYrWZExInZl2QdGCRQuQe
 reCvgfT4JBKGtSBN2i8YMdp4cxIAZ5MoDJXflnXtKKqX4uzNLH2jebEPyD0PmV+Swap+
 USPuVysvlzonnwjX7s4Z/VT8/pd1nQU4PfhZ8tI2KyeqSRCbZU6lIPec5lKV6xDJr8gJ
 QUNw==
X-Gm-Message-State: AA+aEWaUia8sbQKydwjxrstXtIIpn/K72bGTc7CdqsrulZCNmkfH1HsF
 W2y/c4ETcWduD9SDBs0X+xHir3I0DV4H+A==
X-Google-Smtp-Source: AFSGD/U7UNus+oM4OClsTmIw2ZJ1m2N24T3vBwfPO0P9BDA+OoPpq56TqFTCSgCE+tKeuQ2n3Jyp5A==
X-Received: by 2002:a19:7111:: with SMTP id m17mr12258168lfc.64.1544652976263; 
 Wed, 12 Dec 2018 14:16:16 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id w202sm3267lff.31.2018.12.12.14.16.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:13 -0800 (PST)
Date: Wed, 12 Dec 2018 13:43:19 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.21
Message-ID: <20181212214319.biiarkxpeqvh4vte@localhost>
References: <cover.1544124535.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544124535.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_221628_057449_3584CAD9 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 01:57:46PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC defconfig updates for v4.21.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.21
> 
> for you to fetch changes up to 65a8c17a39f62fd646950fa43efcced0d6fe029c:
> 
>   ARM: shmobile: defconfig: Enable SII902X (2018-11-05 12:41:09 +0100)

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

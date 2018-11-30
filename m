Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F478C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C983120673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEdq3kRd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="spczhsZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C983120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p43GazYHTFrNsZ8+Un1mvY03I4zXIzOAQ94djSYCUEI=; b=hEdq3kRd1JfZyy
	CMS8V9VIsSXQ693+Qbh7uW4lA8C9m5JwuT7tQBp1JZlNncwyz3Yag6NLZ6QGQtBeUcNjpsZ+nyJF0
	nz2x0UmIHaE3W8UuOdWeg0bkOGOsgk/ZiVW6hBvSLJBYE4abw5BQu4QC0X9IfHPT2iAuJ1pByhPR4
	a78o3El21nL01TtloKM1L5gjPbP7Nwc/KGMxUN6dU1Qmxvt8XJsleu6Jg2t5JOWUpJXf5R5ynaEGa
	b8ppHtsMzrLsQCW3c3zhbihNQsLYzt1ScVs0A+QmqxpfXLAHCqliZ5CaZ2ffe4CKr8Bd9M3qLG7e+
	RROVBoQHqIrWw7pjJbjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSssJ-0004Hs-Uw; Sat, 01 Dec 2018 00:11:11 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseu-0002My-Op
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:25 +0000
Received: by mail-lf1-x141.google.com with SMTP id l10so5312274lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=siBUjLWaBFjGO926MiprKnpJstdRfBTjhwcbrP6vWGg=;
 b=spczhsZQ0xHtdO6L+V52daTg2Nb9pQc4lL1IkcKwTM5X8/eo0JC3nHARg12YlsKDV2
 BNyPjRIovk3aaO5MCguJdG7ya/masbGzleYfq2kHhI8H/mesn+tXGj73z37ZUxbrREZ3
 IrhA8hEofhM0P42oG0ak81hGepwEe4K59JNiEpYPXmY6b1m0UHOhLlV5f5QSsP8oHEQx
 XPIfXXHbJKTWtRsMuXxLNj5+EokTq+jsDGlgz+H+t14TpWPKaMDD48Na94pwlg/aSpXT
 KB7du0BWv6y4yKCqM0MYGtLnOoBgk0PooOA5HZNrhkk/8KZT4JtHePvvVam1c5UA/SLC
 bFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=siBUjLWaBFjGO926MiprKnpJstdRfBTjhwcbrP6vWGg=;
 b=FyYGnlgw3TbL5EHdeBg3ALVgkmU7iTla+HevzHkQ728WBCj2oJWiz9ObyIuTP3Z3TP
 y/p6BVIKmhww+rSi8SSyaL3/eWGTLPf7O7z6KG3LZJvgaHwO/n3fn9rv5cpD3IGOIXWi
 k0oodyPEiLy7EAkLfgoMU4gsIKqcOTF94sJrgeyEdNGzNkskyV7TIGmsDG3HsEY5Fvev
 wSJ2JfOTohzmsxzJYgkTnVCfrkbwCYmLCSJOwBrH4bYbP255NYcM1neVx6odx49OBRqF
 CnK+WyQh+4uloq9dLHrCXME3Z+d53K5FwCgkJrPGHKLI+hBBS8tyG8TOvw1vWq9vRj0F
 5xKg==
X-Gm-Message-State: AA+aEWaL7rYoKHbDPZfTFgT8tnGzS3vIZy1Y2lfoUsAsFRRpzwftY5Pj
 3VJEkp61dM1N7dLGrcijF3et0w==
X-Google-Smtp-Source: AFSGD/VWJpZduKpSH3QgXB46wJdbhZaRuSyu88Owk/7vrKwmM+XyLeD7f5tooK5Z9R+5wSZei+vQQQ==
X-Received: by 2002:a19:2906:: with SMTP id p6mr4628879lfp.17.1543622228877;
 Fri, 30 Nov 2018 15:57:08 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b17-v6sm1028782ljj.93.2018.11.30.15.57.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:07 -0800 (PST)
Date: Fri, 30 Nov 2018 15:36:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 1/3] Rockchip driver updates for 4.21
Message-ID: <20181130233617.k3c6pze5ofg3wetw@localhost>
References: <49803144.2ZsBJmaiIN@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49803144.2ZsBJmaiIN@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155720_986210_A8551EEE 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 11:06:06AM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin Olof,
> 
> please find below and in the replies the first round of Rockchip pull
> requests. I guess the most notable change is the addition of Gru-Scarlet
> devicetree which - judging by the "silence" in the ChromeOS gerrit - may
> conclude the series of rk3399-based ChromeOS devices.
> 
> Other than that there are smaller improvements all around,
> so please pull.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-drivers-1
> 
> for you to fetch changes up to 24869610e867e9791f0fdab70ff60f246299b859:
> 
>   soc: rockchip: power-domain: add rk3066 powerdomains (2018-11-06 14:13:32 +0100)
> 
> ----------------------------------------------------------------
> Powerdomain support for rk3066 and rk3188.
> 
> ----------------------------------------------------------------
> Heiko Stuebner (6):
>       dt-bindings: add power-domain header for RK3188 SoCs
>       dt-bindings: add power-domain header for RK3066 SoCs
>       dt-bindings: add compatibles for rk3066/rk3188 power controllers
>       Merge branch 'v4.21-shared/pdids' into v4.21-armsoc/drivers
>       soc: rockchip: power-domain: add rk3188 powerdomains
>       soc: rockchip: power-domain: add rk3066 powerdomains

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

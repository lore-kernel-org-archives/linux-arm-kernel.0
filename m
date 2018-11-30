Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC71C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7A42145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxpVG2rg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BYAXVcnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7A42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p2lgQo+toCI1QHEKm1Pobxutd8pcv553JKychCb3B/0=; b=gxpVG2rg1hYqbf
	8K78OpHgspfOmqCZc6f8dc92QuABq1nDQeaYc0Xg+9RarOek4nmIyIXt9T2yArtqKOKLoNn1JEREH
	9GCLLHBnFUyOhrx7YOdkvHmtdpRW3jLGtAe/E4Ij6E4y48YWrRnu07DDqrAgufKhY82BF65VkP8zT
	w5QDFuoKwkgBgIOIICdVxA4vRJY0t7Jq/ayvqNUnpK2dFpnPZanW1WIxXVukO7KgK/91vSbS6Jsuf
	EjsT0J0IXIoj9uxZRGBdf7jzjebMiPDCd8Tc7bNWQ7eh0OJ4yji5zx4rkudCXQcjKGMNoewILH+TU
	DKeSOjYbXuJ9IApaPdgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsim-0007ID-GC; Sat, 01 Dec 2018 00:01:20 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsf7-0002Uw-S6
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:53 +0000
Received: by mail-lf1-x143.google.com with SMTP id p86so5325810lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pQvM0PgK1Fkqq6gwJQW8WgDBljH268aZcMrzDwDDl/I=;
 b=BYAXVcnSn1j9151dylvPEQtV8TzBMelOwiqqIM3781HBBWU5AaHkh4wgBtUhZki6zY
 38xxb0BazBRA3XKyHBDI7k59n5QzyOLciE8ADzQVqZeYQKSNWrVcX0mIwMggNooPgRjB
 XpoSpv4SRjfIFwBDxl/R/Wm8YhVjD21GsxdXPUClWsIKaVL1MNB7DqhmiwUYlPavzNO7
 NfVvIv3lhPRmlPyqFwB+NGgvukUwHV/MWfHb+FbYPQgPyW17UJdQWeHmTNSIMjsSbX+s
 qkMbQnDqgwty4qjaGZsr6iYPAz61fylxcTIRfiYPTbltDVuSDH6lQP9OyBNP42V8yYbn
 pRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pQvM0PgK1Fkqq6gwJQW8WgDBljH268aZcMrzDwDDl/I=;
 b=WWabjLYtJm2CWyRTnTPVqEMJVMzGiCRiOCXiGo3o2ISDSVunyu5rAA1oQu5GWjJZoZ
 K4xEC5F/a+SzBp8lQU9RmN2p6PXMaPXj8VCBnWnnMyeQTEeTDXauSQYWeII8bzqmjTkT
 JyEDTiIvYWzc8ilxQmzQ7COn2vIajpmaD5NNbaCEWHvJKLuKY/+INW8PQhSPKFHxh/ll
 XnIGGIJUQo5KMJe5ycD0WXfb1mczT4Ubkkk9CnxgIBemqrvlM2pYUHGfKkIHZE1qTVjO
 bnoApIAU3LrUc5G1OVsKdhpBnYw18uOdEcyQ93kBGweySmJHsigGISHc/DnyYcMVhBb+
 diZw==
X-Gm-Message-State: AA+aEWb1wcbgAYQku4McOApXi5l2NFZStkyTwohA2CReWkIhUgJjEhm5
 FSvUgxGr+QLD2EQuWpS1luBDnQ==
X-Google-Smtp-Source: AFSGD/VW7ApOKJje87kqFqURh2HoNa1YMTdmsKAvogwLk0s1j/Pul8lNQ5AO5cdWxrdwDI3RWmKN/Q==
X-Received: by 2002:a19:6514:: with SMTP id z20mr4616717lfb.31.1543622241804; 
 Fri, 30 Nov 2018 15:57:21 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id v11-v6sm1015671ljc.57.2018.11.30.15.57.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:20 -0800 (PST)
Date: Fri, 30 Nov 2018 15:45:13 -0800
From: Olof Johansson <olof@lixom.net>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] Versatile Express defconfig updates
Message-ID: <20181130234513.ttuedxteaql4pozf@localhost>
References: <CACRpkdbGp1-TKn41eBq9JijGsYqY83MLWEbr-BU6yRJV+bsoDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbGp1-TKn41eBq9JijGsYqY83MLWEbr-BU6yRJV+bsoDg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155734_959457_A7711DC0 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, arm-soc <arm@kernel.org>,
 Liviu Dudau <Liviu.Dudau@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 08:47:38AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> following the DTS update to fit the PL11x DRM driver, this is
> an accompanying defconfig update that switches the versatile
> express family to use this driver by default.
> 
> The defconfig was a bit out of date so I first update it to the
> latest Kconfig structure then apply the DRM config changes
> on top in a separate patch. This is a v7 patch set that has
> been interated and tested for quite some time.
> 
> Again I agreed with Liviu Dudau to send these updates to ARM
> SoC.
> 
> Please pull it in to ARM SoC for v4.21!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/vexpress-defconfig-arm-soc
> 
> for you to fetch changes up to 7de642a3815d7fa61df0b7f94257034b10a8bfb2:
> 
>   ARM: defconfig: Enable the PL111 DRM driver on vexpress (2018-11-29
> 08:35:21 +0100)
> 
> ----------------------------------------------------------------
> Versatile Express defconfig updates:
> This activates the new PL11x DRM driver with the
> Versatile Express family of reference designs.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

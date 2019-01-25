Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C8C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF58E218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nhWOl3W6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVylY3MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF58E218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7LJFkPFRGBJMcOq41b7OEVv+dr+XtL3uq/JTG/e11L4=; b=nhWOl3W6JhocIS
	wbY4LBaE3p9GT6rWDE3WYCd7jvutbJnPGi2YB6WT7BQrqPEmi3oNOfawmQvtGYmYz+RanyG6c5TNi
	Jc/HboxOMAJxFPxbamSFCH/KH83538mMEQuH/J/00Xs3Y6eRYRzx+jwLAlB0rf6dxoPnlZH7ErbQ2
	1SU1geEsUp2IMJQd3HnLoG2c8wWb3a8jprD/rZWjJdAPEMXomMCsqH65Cb+gBbtPBfauhdA+asUoq
	hKjF0LbglWJfSGTYDJVggMqxgoG54g3C5B+R2BLLdBCN9ncEu0VrStRwa4Z0Jp5VFIzEMGJKmxJlp
	vG6/LhNsIhd8K1DOhoUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn34H-0003Kc-12; Fri, 25 Jan 2019 15:06:53 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn343-0003Jq-DW; Fri, 25 Jan 2019 15:06:40 +0000
Received: by mail-vk1-xa44.google.com with SMTP id w72so2189747vkd.5;
 Fri, 25 Jan 2019 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2tuwG0ftAhvsmIdX92d0e/Lmg6rffrspm0jvnvVUl2s=;
 b=dVylY3MGyGM7FnJ2iL26hB7mzL8KzLS5iqz4PdygfGmGDv5GmK7YXLN5xKdciXt5Rp
 CHd2VjSvCL6j9a/3kY93rSVQNVOupqdAElZdGrhsJ+9+I0SXDA5Saijq59ixp0q0Ce7F
 jKErQPON1E5F28LZH7gWrXVXB4u5nOJhe6Dwook5YePcWZxZ0VqTMIVZZDwiTGYvk6QU
 eSA/Mp+pb++LzW4BSWWNG3xcNdMzzwCYWMFFY5ZQp6pUc8byTWQsdYx2V9F+Bf1wEQDo
 vknSJ3ukKoNS5ud7TFYVIa4owDdSBGPCTgw/UJ9/9UAQ9yr9HeqT6pAToagWcvCSZlOJ
 T7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2tuwG0ftAhvsmIdX92d0e/Lmg6rffrspm0jvnvVUl2s=;
 b=LaKxXmjZsRCk0vkXnd3nKIfcrZwlP1xrfb/ul45AalObQRvo9mo6aL2RHCU/bb7+Yg
 qeobHX3IQ+Nezf2tlzd51hT11Nk31wXFRNMK4ane5CPRKnYSN1rk1uWyM+5dN8nI0lcz
 N/IKNphs/EsHaJr+rC+atC4i2x5ejlsbC10N3UXr4TVRsdfcbXlVcVT2O3GgqxBDEIwg
 3G5EOm4mhS3a4/xCfW19IHXVBTakHtl7iKPQN4nczoRXubtgtR/9dWjRwMpHLHQ3aLXI
 WFg2rN0FGxr9K88ew1nyp+tBeaSsBf87/cBdoNqSGGy//txst5MvvSYjsnM/Jvl4yrRz
 lyUQ==
X-Gm-Message-State: AJcUukc0zQsd0Z+EsG5bTxHdggdauZ6/bOA/Ji/3D1GQwts+ikfxsD7/
 R5aAhbMPgspiRo+p11kQjn8gUTo9U5fJReXnAEk=
X-Google-Smtp-Source: ALg8bN4sX9Tzc32rkLIDSwECpOZhwMSyIALQo8FVD52KnDlJZmcALk9/ODEfv6yjhogrbFpLc60DHjL6aXuYC19VAAo=
X-Received: by 2002:a1f:d02:: with SMTP id 2mr4375381vkn.23.1548428797068;
 Fri, 25 Jan 2019 07:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-27-daniel.vetter@ffwll.ch>
In-Reply-To: <20190124165831.16427-27-daniel.vetter@ffwll.ch>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 25 Jan 2019 15:02:46 +0000
Message-ID: <CACvgo52YJ0kSBVJryELvZn70--4rbPr7R=TJdRgbVr1fEVr2yw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 26/26] drm/<drivers>: Don't set
 FBINFO_(FLAG_)DEFAULT
To: Daniel Vetter <daniel.vetter@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_070639_478372_3B4D4AE9 
X-CRM114-Status: UNSURE (   7.11  )
X-CRM114-Notice: Please train this message.
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
Cc: "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 ML nouveau <nouveau@lists.freedesktop.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Inki Dae <inki.dae@samsung.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Alexander Kapshuk <alexander.kapshuk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-tegra@vger.kernel.org,
 Daniel Vetter <daniel.vetter@intel.com>, Ben Skeggs <bskeggs@redhat.com>,
 LAKML <linux-arm-kernel@lists.infradead.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 17:00, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> It's 0.
>
I'd add a bit more information here. Feel free to reuse as much/little
of the following:

Both macros evaluate to 0. At the same time flag is already set to
zero since the struct is kzalloc'd in framebuffer_alloc().
As called by drm_fb_helper_alloc_fbi() in the DRM drivers.


-Emil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

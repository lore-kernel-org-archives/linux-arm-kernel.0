Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70572C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:21:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400112075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gU7H1aTC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQINxOMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400112075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hX3sWFJCtRrBuSp0qH79ivNh0iEK0iZvd9ZoiRh+1xc=; b=gU7H1aTCeoQY25
	ITZIMphkd1IMRiyXp2qJ28Ryz3EdAbbYu78qbHg+ZjHLOrz4/xZG8whIrs4ofGGq137r8+f5PCCik
	CMyP9vRUGxqfnFmfCxSrrfyWwDJBVIetIJJbHUOx6R/Zq7K1lTPnidFXDTHDn2ZRmzW8hgWi6EJW5
	WRcAyw0TYRYRqjFL4eBrpptQDeXh8x69f7PN9A3WKkeZEpoa0AzJEsX8Hsr6kfbwtbxHHpilgyfgr
	LNzwbGcENI/P37Fyeu2bBV3E8NYgG613vfg4JQAjNhQehCTn6PBrvEuPK2TxwzCsqHUgXk/UgyNNl
	Y5/BDIv4uPrHlOc62Anw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXIVQ-0001nz-E0; Thu, 13 Dec 2018 04:21:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXIVM-0001nB-2K; Thu, 13 Dec 2018 04:21:46 +0000
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C73320880;
 Thu, 13 Dec 2018 04:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544674892;
 bh=W14iNjL5prFtXssrAezogBdWYOtqCQcslOu1nXO2DPI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DQINxOMOOCFIuAe2R4TB6ZnzeW3Ezuo3snFQfJm5vi6IKT48y0cVyYRrsOsB47Udd
 Xzws+IyRtWWtwXBzhaHIG3J1aIMo7y9qjnhSNM9fvF6QOqBEd9/Gqvz/4uxRfnAAc/
 12FcqbKYMtOfIbTXLfCmP0RW7GnIJvcBXajNEG4s=
Received: by mail-wm1-f42.google.com with SMTP id f81so910294wmd.4;
 Wed, 12 Dec 2018 20:21:32 -0800 (PST)
X-Gm-Message-State: AA+aEWZ83/nZdaqFUnGqfdkafG6Exqr1cZFU5FfyzBDL0MH6uKfWnEir
 KW1EH4/mO0v/xB9XrFx4HEpCNyu37eOpVIENEco=
X-Google-Smtp-Source: AFSGD/WqpPeGLayPIhjYGwhngaZHSOvb9r2Rsqf3CKrLR38I1BFy6vfuMSd5MfSw3shFHTrqMoMCmBqO6zlPh3fD85g=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr8940947wmu.52.1544674891066; 
 Wed, 12 Dec 2018 20:21:31 -0800 (PST)
MIME-Version: 1.0
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 12 Dec 2018 20:21:04 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrQoLNonZDHqCJqV8iihxhB1u4vu23HORO0GbN4fz7xzQ@mail.gmail.com>
Message-ID: <CAGp9LzrQoLNonZDHqCJqV8iihxhB1u4vu23HORO0GbN4fz7xzQ@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
To: =?UTF-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_202144_140333_E1F2B334 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 weijie.gao@mediatek.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It looks good to me. Thanks for bringing the improved version soon.

Acked-by: Sean Wang <sean.wang@kernel.org>

On Wed, Dec 12, 2018 at 6:28 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v1:
> - Revise commit message
> - Change all pinctrl cores to non-visible symbols
> - Drop EINT_MTK in PINCTRL_MTK_MOORE
> ---
>  drivers/pinctrl/mediatek/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index d8cb584..1817786 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -17,7 +17,7 @@ config PINCTRL_MTK
>         select OF_GPIO
>
>  config PINCTRL_MTK_MOORE
> -       bool "MediaTek Moore Core that implements generic binding"
> +       bool
>         depends on OF
>         select GENERIC_PINCONF
>         select GENERIC_PINCTRL_GROUPS
> @@ -26,7 +26,7 @@ config PINCTRL_MTK_MOORE
>         select OF_GPIO
>
>  config PINCTRL_MTK_PARIS
> -       bool "MediaTek Paris Core that implements vendor binding"
> +       bool
>         depends on OF
>         select PINMUX
>         select GENERIC_PINCONF
> @@ -45,14 +45,14 @@ config PINCTRL_MT2701
>  config PINCTRL_MT7623
>         bool "Mediatek MT7623 pin control with generic binding"
>         depends on MACH_MT7623 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7623
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT7629
>         bool "Mediatek MT7629 pin control"
>         depends on MACH_MT7629 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7629
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT8135
>         bool "Mediatek MT8135 pin control"
> @@ -93,8 +93,8 @@ config PINCTRL_MT6797
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
>         depends on ARM64 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT8173
>         bool "Mediatek MT8173 pin control"
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

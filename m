Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B950C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0565F20578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qgRfrS+C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nl04OON6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0565F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=htpwMezC/KNbUSt3lNlwtzdVpOVuVrH6lgzWp6SqvS0=; b=qgRfrS+Ct2w/V2
	+RUhwZL58YjZqMad0DxgBQQoo9wfhjUTiFykwa6yTMKSm2Eubis1zLT/bBdFQtfk+geUTbAHePnmx
	wxomdgeNrE6m/JwofxDMLxmEqKlYg6QxKy0iQaQAQCmS3NmFKkZd3p194WgMqHZqb3A42fnMs1Esm
	tizkAzbNOvp300eGoucLm9d3njRI+nobNcAJtfSjbadS7VIQV19Vussu7nsUXor5lfVFGJVoKFy66
	d+jNICCly9Crkh+Q5C59kL4Rw0dlz/R8JqAEprHwAQ6nZlT2ktzHuhNIEseB2rAxYm3A9K1qt2PqW
	fx4/CLKBrHV1kvaaxsSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYlkL-00065P-5q; Mon, 17 Dec 2018 05:47:17 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYlkH-000643-6i
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 05:47:14 +0000
Received: by mail-yb1-xb42.google.com with SMTP id f9so4628718ybm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 21:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ctqFADV58yUhr8uQS0dXF/3lM/bQh2NGAGf199ZWQI=;
 b=Nl04OON6EHmrKBIgMWUDlEw4bRHJLcXOi0YCSzgMRDZ+U6R4nMYKGJb5/x4I7+LJ1D
 sPhgyHS0xO+rAxQRGG1AFsr0LF+Z59ZrhCkMTBnOPWEJu3+oKLj6+kB+/nOeei/mjRXV
 L0wkjRpV/MHPlHYOzbjqJwdfMX1ynqVgT19TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ctqFADV58yUhr8uQS0dXF/3lM/bQh2NGAGf199ZWQI=;
 b=EvnY8BdATWOat8sYzBvuFb3GktLd5HRek/w0+gaCylILviIJ8iIWqEydFQ/9hLPi6v
 mgTV0hCBc1jm8UroO1S5xOv6ZuJ2wWv/NTPIGI+LSXjB//K+0aqQfapWTnVoqbF4wEXn
 BpPCvTaq9+Vp1vujMZl3hByK8UVgYt73CCB7FtFvhtpKLSbHVmRyUzmwWwDB7bP0pPOb
 dpsI2eJAzy0k9qEy9PUnKdse+cTvNQ6HuMRoIgjWGfOZEDgtcLEpFLsg9PuKZSCvi/BM
 4tSm++pmr3QJWTYEOfgBmci4a2cUjoF0X6T1E1TESjIiYcD3IkuB610WpfCB6TQXFqXM
 SreQ==
X-Gm-Message-State: AA+aEWYdAcM3VpJktglb+gXaFGqun2K0nV/OJ17WDnp0mIjE+Kzyn/ip
 ucymT7XA7GIzWZYxQeFQ2BkQIoDy0IU=
X-Google-Smtp-Source: AFSGD/XCu0d8s/m8Bih4qS8/AUOTbd0nChNNmfgKXCkSAK6vGJ5BYXnQJS+N6iCr9UOoouhyerudBA==
X-Received: by 2002:a25:3444:: with SMTP id b65mr11551042yba.5.1545025620865; 
 Sun, 16 Dec 2018 21:47:00 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com.
 [209.85.219.170])
 by smtp.gmail.com with ESMTPSA id q189sm3038303ywg.75.2018.12.16.21.46.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 21:46:59 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id d2so4628273ybs.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 21:46:59 -0800 (PST)
X-Received: by 2002:a25:d644:: with SMTP id n65mr11687359ybg.204.1545025618887; 
 Sun, 16 Dec 2018 21:46:58 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 17 Dec 2018 14:46:47 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
Message-ID: <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
Subject: Re: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu
 node
To: jbx9999@hotmail.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_214713_240977_44627F0F 
X-CRM114-Status: GOOD (  20.25  )
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
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Sean Paul <seanpaul@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Johan,

On Sun, Dec 16, 2018 at 12:03 AM Johan Jonker <jbx9999@hotmail.com> wrote:
>
> A MK808 TV stick with rk3066 processor boots normal with logo and console.
> After the boot the monitor remains black.
> This patch fixes a vblank timeout crash by adding qos_hdmi and
> HCLK_HDMI to the pmu node.
> The HCLK_HDMI clock and the RK3066_PD_VIO power domain
> will now turn on and off together.
>
> Signed-off-by: Johan Jonker <jbx9999@hotmail.com>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 6 ++++--
>  arch/arm/boot/dts/rk3xxx.dtsi  | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

Thanks for the patch. Unfortunately, it looks like you didn't add the
necessary mailing lists to the recipient list. For reference, the
./scripts/get_maintainer.pl script in the kernel source tree should be
able to give you a reasonable recipient list. For now, I added the
mailing lists on CC and replied without snipping, so people should be
still able to review the patch.

Other than that, It looks reasonable to me, but we need someone with
access to SoC documentation to check it. Heiko, Sandy, is that
something you would be able to help with?

> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 30dc8af0b..6e7cdde84 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -672,13 +672,15 @@
>                                  <&cru ACLK_IPP>,
>                                  <&cru HCLK_IPP>,
>                                  <&cru ACLK_RGA>,
> -                                <&cru HCLK_RGA>;
> +                                <&cru HCLK_RGA>,
> +                                <&cru HCLK_HDMI>;
>                         pm_qos = <&qos_lcdc0>,
>                                  <&qos_lcdc1>,
>                                  <&qos_cif0>,
>                                  <&qos_cif1>,
>                                  <&qos_ipp>,
> -                                <&qos_rga>;
> +                                <&qos_rga>,
> +                                <&qos_hdmi>;
>                 };
>
>                 pd_video@RK3066_PD_VIDEO {
> diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
> index 97307a405..1f9496e81 100644
> --- a/arch/arm/boot/dts/rk3xxx.dtsi
> +++ b/arch/arm/boot/dts/rk3xxx.dtsi
> @@ -187,6 +187,11 @@
>                 reg = <0x1012f280 0x20>;
>         };
>
> +       qos_hdmi: qos@1012f300 {
> +               compatible = "syscon";
> +               reg = <0x1012f300 0x20>;
> +       };
> +

Is this really common for all rk3xxx SoCs?

>         usb_otg: usb@10180000 {
>                 compatible = "rockchip,rk3066-usb", "snps,dwc2";
>                 reg = <0x10180000 0x40000>;
> --
> 2.11.0
>

Best regards,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065C8214D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="slgj50Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065C8214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xt00VbeBry2vrDNHD/4WbE0OEj4GkiPFL+hvSQwY+9Y=; b=slgj50ZdVqiqXP
	3v/ieNglyzSkJZfgFTC3LVm1ml/VMMPEV2EEEvAQmIMwVC8ePhpVUGI9db4s5IVR7aHRdC+M13OCH
	CLAwhaf5IejImAPYdigpbvbjXWfOaxneNLgXvXsO+O00+l8zK3azPT128zO8b2oYGoUkflr3exhbj
	ZjgOE489750E4ljbQJl679smJSpi8S8iP3H5W3m3UlvDs8bxta1ypXbSaAWtt812YY5UOd0kRPGhA
	XlyyDW69L3yyBPnR69IPgzlB2Ee0BlybOLQ+FCPffX4nCg0lk+29fci9INUDveZgKRH04raQIX2av
	foxCRFs7ZDj6gPs85rrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlPl-00069J-9T; Mon, 03 Dec 2018 10:25:21 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlPg-0005Qx-Dv
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:25:19 +0000
Received: by mail-ed1-f66.google.com with SMTP id j6so10221222edp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lCWM0usXHMZ510hOwcbi6aXdkoyepRwcwnMM+MoSlmM=;
 b=dgc7ZbHH7OpfBuLlQCUcy8v1Mv7sesIYVfAJstCt2tBTJM+tidfpTzSlUDhmCLIiWM
 Vcn70bWmbAByiKU/GTkcQJrWMS8dBF6r1Nv1EA35EhyOV6gxHk9zo0nU3x3Bdn2nfH9K
 MGWz3oHCltLGfOXOaCWMf6tG9WlA1gJIlUJj2rxv+kCzJzk8VetNyyDlo0SApdJH2wKo
 FuiSngkxnLrf0LSOdOZ3AIECBNXEcz+7H98DYKpSxI9OOh/IhDVqcKdDwu6iMRUfqvIo
 39ka1w62/sC+FjprFqrTUDWfmVp9YxfJz142eJMI4Lwocnv750ze6aul9YHgb9xB+9jk
 Brxg==
X-Gm-Message-State: AA+aEWaKmoRzB3elwsBfX5Y3G6hawaUlxJx3BTf00fF0+XNdPnRLHfX+
 f0wasOWjjHxPVgm56MJA1lEvqot4JIM=
X-Google-Smtp-Source: AFSGD/UqA0RgDntQhCskKuSsm6aBOlQsWG1SkCO2MBpQia3c7ZyN1IOAXQltbvo31W0dclJ0euRPUg==
X-Received: by 2002:a05:6402:14cd:: with SMTP id
 f13mr14284725edx.224.1543832704701; 
 Mon, 03 Dec 2018 02:25:04 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53])
 by smtp.gmail.com with ESMTPSA id k31sm3923032ede.5.2018.12.03.02.25.04
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:25:04 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id p4so11505965wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:25:04 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr13984973wrv.188.1543832704129; 
 Mon, 03 Dec 2018 02:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
 <20181203100747.16442-6-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-6-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 18:24:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v6441wV7PM6q=vF2cpJtP9BGdYjQQqNU54rqELNJ5YcmdQ@mail.gmail.com>
Message-ID: <CAGb2v6441wV7PM6q=vF2cpJtP9BGdYjQQqNU54rqELNJ5YcmdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: a64-amarula-relic: Add OV5640
 camera node
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_022516_470979_1031B99F 
X-CRM114-Status: GOOD (  19.50  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Amarula A64-Relic board by default bound with OV5640 camera,
> so add support for it with below pin information.
>
> - PE13, PE12 via i2c-gpio bitbanging
> - CLK_CSI_MCLK as external clock
> - PE1 as external clock pin muxing
> - DLDO3 as vcc-csi supply
> - DLDO3 as AVDD supply
> - ALDO1 as DOVDD supply
> - ELDO3 as DVDD supply
> - PE14 gpio for reset pin
> - PE15 gpio for powerdown pin
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 54 +++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  5 ++
>  2 files changed, 59 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 6cb2b7f0c817..9ac6d773188b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -22,6 +22,41 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       i2c-csi {
> +               compatible = "i2c-gpio";
> +               sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +               scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

FYI our hardware doesn't do open drain.

> +               i2c-gpio,delay-us = <5>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ov5640: camera@3c {
> +                       compatible = "ovti,ov5640";
> +                       reg = <0x3c>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&csi_mclk_pin>;
> +                       clocks = <&ccu CLK_CSI_MCLK>;
> +                       clock-names = "xclk";
> +
> +                       AVDD-supply = <&reg_dldo3>;
> +                       DOVDD-supply = <&reg_aldo1>;

DOVDD is the supply for I/O. You say it is ALDO1 here.

> +                       DVDD-supply = <&reg_eldo3>;
> +                       reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
> +                       powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
> +
> +                       port {
> +                               ov5640_ep: endpoint {
> +                                       remote-endpoint = <&csi_ep>;
> +                                       bus-width = <8>;
> +                                       hsync-active = <1>; /* Active high */
> +                                       vsync-active = <0>; /* Active low */
> +                                       data-active = <1>;  /* Active high */
> +                                       pclk-sample = <1>;  /* Rising */
> +                               };
> +                       };
> +               };
> +       };
> +
>         wifi_pwrseq: wifi-pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 clocks = <&rtc 1>;
> @@ -30,6 +65,25 @@
>         };
>  };
>
> +&csi {
> +       vcc-csi-supply = <&reg_dldo3>;

But here you say the SoC-side pins are driven from DLDO3.

This is a somewhat odd mismatch.

Regardless, the ov5640 driver enables all three regulators at probe time.
Shouldn't that be enough to get the I2C bus working? The pin voltage
supply does not belong here.

> +       status = "okay";
> +
> +       port {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               csi_ep: endpoint {
> +                       remote-endpoint = <&ov5640_ep>;
> +                       bus-width = <8>;
> +                       hsync-active = <1>; /* Active high */
> +                       vsync-active = <0>; /* Active low */
> +                       data-active = <1>;  /* Active high */
> +                       pclk-sample = <1>;  /* Rising */
> +               };
> +       };
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index d32ff694ac5c..844bb44a78af 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -538,6 +538,11 @@
>                                 function = "csi0";
>                         };
>
> +                       csi_mclk_pin: csi-mclk {
> +                               pins = "PE1";
> +                               function = "csi0";
> +                       };
> +

This should be a separate patch.

ChenYu

>                         i2c0_pins: i2c0_pins {
>                                 pins = "PH0", "PH1";
>                                 function = "i2c0";
> --
> 2.18.0.321.gffc6fa0e3
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

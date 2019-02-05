Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DAFC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:53:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462BA217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwjW/eUz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWetBl7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462BA217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nulbkw3HTGOtF2FUF6s74uUjjPbusl4EwIX8ZOXjAbo=; b=TwjW/eUzXLYstG
	sk5hQIDLvL2dKp3XBcgT6HyF8WB0meo84isjtRfTpYXyiANn3nhasPajvGhUZfTo0Lvm0fcQHgURP
	JlHDbi2YgEZjoPeacV/cq2vxmLJd+WK/DO5Id/p9ojtmG2ItklppDEvsZzZHrFQdEvlw1TobhILow
	Axo0hWY1MVtWd3pFxWJutWu/JhxsC3U4+UpX0cjMctCfY2vMGs6nvfECK/jKdDRECfPb5dVGlY6Vs
	kiKII0lOnaGUeDKsj+V9MiDRzhZg2R8zP9eqzHyg5UL+7IQRkuOL+7eL9oSodDtBP3ZIYIznstk7o
	Epy8hq95y9dmL/m1UF7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6mO-00033u-Qn; Tue, 05 Feb 2019 19:53:12 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6mF-0002wo-Rz; Tue, 05 Feb 2019 19:53:10 +0000
Received: by mail-ot1-x342.google.com with SMTP id 32so7822875ota.12;
 Tue, 05 Feb 2019 11:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x3K9+7riqdplK/twrBsGKzhH/FJ9S6L7/qosBdyD1KU=;
 b=jWetBl7hO8gkVO7mWoBEu+EYzm+lrIfdHRchiUO1aGGPkfHFBUW+E6p+YKqkeXh0SN
 FDGSdrRGBLq/iNC8/xS7wkaOWVOxrefRvxaG0vljQy2wHjNmMxatA3vNG3RsetA6gqya
 s9cizYsZMO6nCQdbfT43tFSkdbF8ssFgO/shH1AfBhMzWclWICxyaA2dJVd3sgM0cJ+q
 fwiDX9ggUzMLFZkTbqsiU/2+JgVsGxkSy8gJAIuRffAW1QE46Uc5tnrOovaTscjfaV/a
 hDbBJ3DfVnmc5f+fcSZbm/486TG3KRyem8j2yE+ilRQQfxzT9dmnuXPdg/0LZ674uarV
 9bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x3K9+7riqdplK/twrBsGKzhH/FJ9S6L7/qosBdyD1KU=;
 b=Do5V/NMNvmo8+sl+3KPtQW2+WLxf/wJ06L1UiC2uqSUAjF57y8gVhB+MjA6vaRb+vc
 Cos+P8Nh+/vxFqdaeGQXzIwYRPfrq6i9QMwicgmE2TTddOBnPhLKCIcKMN97G7aLjCf3
 26lXlAB19H6TrbQ3CCHrBD0iwvj4tM3TvGz+nVpsqpGXI3inW7plQl43ym4vZ21GudGu
 X6wfiI8vDRiMuT8a6DBt9fASNSUymq7DJ3NV34M42Sc1l6kpwpQ6CwL6bVuu90BQK5TG
 XzwrskTm6EchhVn6sjDBceVa4enJazmtuXpUW6vlFIItgzdILfYrggiuHTRSzx07m4HT
 aqhQ==
X-Gm-Message-State: AHQUAuZf7DbqspzaQ20B1fB6Y0e4IPb59pe/8TSLfkKdou6bWjDTd8tu
 JXS1YTrH8WBey5q9FmkonkiW4eS/NRAxKd0HykY=
X-Google-Smtp-Source: AHgI3Ian9GBS/m4GZ3FV48eyq83fJ0M+jfAYTPTCWEdi0rxg98Kk0sbWpGUz8hAH2PZiOTS0i8sj/wBEofeU1HGyX3o=
X-Received: by 2002:aca:39c6:: with SMTP id g189mr3486739oia.201.1549396382550; 
 Tue, 05 Feb 2019 11:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
In-Reply-To: <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 6 Feb 2019 01:22:49 +0530
Message-ID: <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115304_296944_E510D930 
X-CRM114-Status: GOOD (  34.46  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Tue, 5 Feb 2019 at 02:05, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 4, 2019 at 9:03 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin,
> >
> > Thanks for your comments.
> > Please find my comments below.
> >
> > On Mon, 4 Feb 2019 at 18:59, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Anand,
> > >
> > > On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > This patch enables the USB Host controller (USB0) and the relative USB0 PHY.
> > > > From the shematics GPIOAO.BIT5 gpio input for the PWREN signal of the
> > > > USB_OTG controller (usb0) which is also linked to USB_HOST controller (usb1).
> > > > Add missing phy-supply link to both  USB0 and USB1 phy controller
> > > > This changes fixed the power issue on usb ports. Changes help fix usb reset warning.
> > > I prefer to change the way patches 2 and 3 are split:
> > > - this one should only add the regulators and link it with the USB controller
> > > - patch 3 should enable usb0 and usb0_phy
> > >
> > > the reason behind this is the "Fixes" tag below. it's good to have it,
> > > so please keep it in this patch!
> > > however, enabling usb0 is not a fix for a commit which enables the
> > > "USB host controller on Odroid-C1/C1+" (which is why enabling usb0 and
> > > usb0_phy should be part of patch 3)
> > >
> >
> > Ok I will split this changes as per your suggestion.
> thank you!
>
> > > > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > >
> > > > Fixes: 2eb79a4d15ff ("ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board")
> > > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > Changes from previous patch.
> > > >
> > > > Fix the subject and commit message as per Martin's request
> > > >  --Add the signal name in the comment
> > > >  --Replace vbus-supply with phy-supply linking the power supply to phy node as pointed by Marine
> > > >    which a PWREN signal in the USB_HOST controller (usb1)
> > > >
> > > > USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
> > > >    phy-c1108820.phy.1         2                                 0mA     0mV     0mV
> > > >    phy-c1108800.phy.0         2                                 0mA     0mV     0mV
> > > > ---
> > > >  arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > index 58669abda259..bfa472a679d9 100644
> > > > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > @@ -83,6 +83,22 @@
> > > >                 regulator-max-microvolt = <5000000>;
> > > >         };
> > > >
> > > > +       usb_vbus: regulator-usb-vbus {
> > > > +               compatible = "regulator-fixed";
> > > > +
> > > > +               regulator-name = "USB_VBUS";
> > > > +               regulator-min-microvolt = <5000000>;
> > > > +               regulator-max-microvolt = <5000000>;
> > > > +
> > > > +               vin-supply = <&p5v0>;
> > > > +
> > > > +               /*
> > > > +                * signal name from schematics: PWREN
> > > > +                */
> > > > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > > > +               enable-active-high;
> > > > +       };
> > > > +
> > > >         tflash_vdd: regulator-tflash_vdd {
> > > >                 /*
> > > >                  * signal name from schematics: TFLASH_VDD_EN
> > > > @@ -295,8 +311,18 @@
> > > >         pinctrl-names = "default";
> > > >  };
> > > >
> > > > +&usb0_phy {
> > > > +       status = "okay";
> > > > +       phy-supply = <&usb_vbus>;
> > > I'm not sure whether phy-supply is correct here
> > > with the PHY framework and the dwc2 controller regulators can be set as:
> > > - phy-supply (inside the PHY node)
> > > - vbus-supply (inside the dwc2 controller node)
> > >
> > > phy-supply is always enabled when the PHY is enabled.
> > > vbus-supply is smarter: it's enabled whenever the controller is in
> > > host mode (or OTG detects hosts mode), but disabled in
> > > device/peripheral mode
> > >
> > phy-supply enables the power per port power setting which get on when
> > device is connected.
> the actual dt-bindings description is "a regulator that provides power
> to the PHY", see [0]
> (note that it states that it powers the PHY, not the bus or any
> connected device)
>
> > vbus-supply controls the D+ D- signal during high seed data transfer.
> I believe this is not the case. the vbus-supply seems undocumented at the moment
>
> however, the dwc2 driver has separate supplies for vusb_a (analog) and
> vusb_d (digital), see [1] (these are used here: [2])
>
> VBUS (in my own words) is the +5V power signal which is provided by
> the USB host to power the USB device.
>
> my interpretationfor the Amlogic SoCs is:
> - vusb_a and vusb_d are generated internally, not sure if there's an
> external fixed regulator
> - there is no phy-supply (the PHY itself is powered by clock-gating
> using the CLKID_USB clock)
> - usb0 VBUS is controlled by GPIOAO_5
>

But as per the device tree binding

[0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
[1] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt

its uses phy-supply to enable power to usb phy which seem to be correct option.

>
> Regards
> Martin
>
>
> [0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt
> [1] https://elixir.bootlin.com/linux/v5.0-rc5/source/drivers/usb/dwc2/core.h#L72
> [2] https://elixir.bootlin.com/linux/v5.0-rc5/source/drivers/usb/dwc2/platform.c#L293

Best Regards



-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

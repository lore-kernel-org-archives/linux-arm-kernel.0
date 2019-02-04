Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1532F2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EG9v+FRl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdGQjgRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8qU+vR8pFjmM9FiLYWL3ZVf0jWT+jjB+2SKhmfm4/c8=; b=EG9v+FRlOw9Op9
	lGO06+josz5XrWg33vt7PHJdVbKsQVqdpSAHA7KgDXP/4pvlaFUkQL5yBhI+FEC6QCGpIvo1u9V2I
	mM2q/zYIwCUBDgJTGUrsQ7UbtJfuxU3CdpMlI9CkKLSTf9Sr5bm2XioemaiCTn/0d/ungx+lhoxRO
	BVNpqpJQzMGY0nwqK701aVg3nh1QL4xctUFlpEUc5ncgS/RpfMQRNLtI2ZVRIV77ND+0HWBX6T8B7
	w3Nk/zrhTd62MEW8IuACiM/T3CIMhUxr5j1antnSvV7ptUDoEL6l6iwMNhCc/WFheFLNW/VGo62di
	l/Z0F/zp1n8gM4LqmMOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkSr-0001sC-Jt; Mon, 04 Feb 2019 20:03:33 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkSo-0001rm-Q4; Mon, 04 Feb 2019 20:03:32 +0000
Received: by mail-ot1-x344.google.com with SMTP id w25so1872316otm.13;
 Mon, 04 Feb 2019 12:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uNkypZbw7O46aY6tUgz6AXU509TwaQA2R8bcO5ZYIEQ=;
 b=WdGQjgRGxAXuDLk9nPj0Fmsbq91jUiGtFpUUlLiQ2S+yiFJrpyVPuDm3JAL0PYPQIg
 lB4FtNd2rzY10ZQrDexxOK1k0ufpy0n8G8Bxux3zTl+b2bBb+bzODk8H8UCFzOZO5h06
 IvB9zdNWdl2mmHOqAdoPhSrvPMysFivSzBQKdBxpAwek4cttxiZeobwIeBd02HI681Fx
 UvBLiohmKE6GbVNpmDJcgN/L+B7M2NfhMcVYmK0xJy0hhR6uEW7i5eh77Yyr/OTPC0LT
 UFJwST3/YZpuMUODHZu0MUw4J+2VkscfewBHCyjqFu4VLggh48vj+dwhu5kQIm+32C8E
 5A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uNkypZbw7O46aY6tUgz6AXU509TwaQA2R8bcO5ZYIEQ=;
 b=ia2zhwncS7cNHtVt89ObfvVtdom6At9AycAsElVUAQ6ap0HKe5x4+kBD4loagbLnMd
 3UlM41aVnWyFYj4SIQ/mOZ2ai91OX9Lwjz+fucWE8HuqWiFKGxOvvs6X1v6xMGcwnkFD
 x5lBV9B/SAmv5+35X/PCC4C496V+stIewjlPfeqk3rEB1Rq5a3XVk4qsPFQlbvnYGXS1
 BxmLnJJh61yR+awBHNsMrKc4NINcb+Unhgg/inGlk/om+g+CQD0JYW7QzZ5fZfwM87SH
 papiqgpvVZAdsd6o9oHmDlHwIGFgUCxcJxfy8remgVEx4rEGqBPweTHIS0qTIeZ+6mv8
 aHzQ==
X-Gm-Message-State: AHQUAuYvBhj7GBcF7jhf8hN7E84eeRJ4/Q8dnurUHrR7/Niss/kJkNAZ
 e1ZaFgeux4/4fnGZgwDnvLnkVJ647pBj97cFZBE=
X-Google-Smtp-Source: AHgI3IbNfUYRG+vD8AXyLQ24T2/LxQNnW7wuoAZCWIqK/iMLPHqXy1NojFKjZy7/JvG9jNsbrxO3tG6PHQDnMVx0EyA=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr576393otk.63.1549310609803;
 Mon, 04 Feb 2019 12:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
In-Reply-To: <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 5 Feb 2019 01:33:16 +0530
Message-ID: <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_120330_841917_15C1C805 
X-CRM114-Status: GOOD (  28.44  )
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

Thanks for your comments.
Please find my comments below.

On Mon, 4 Feb 2019 at 18:59, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > This patch enables the USB Host controller (USB0) and the relative USB0 PHY.
> > From the shematics GPIOAO.BIT5 gpio input for the PWREN signal of the
> > USB_OTG controller (usb0) which is also linked to USB_HOST controller (usb1).
> > Add missing phy-supply link to both  USB0 and USB1 phy controller
> > This changes fixed the power issue on usb ports. Changes help fix usb reset warning.
> I prefer to change the way patches 2 and 3 are split:
> - this one should only add the regulators and link it with the USB controller
> - patch 3 should enable usb0 and usb0_phy
>
> the reason behind this is the "Fixes" tag below. it's good to have it,
> so please keep it in this patch!
> however, enabling usb0 is not a fix for a commit which enables the
> "USB host controller on Odroid-C1/C1+" (which is why enabling usb0 and
> usb0_phy should be part of patch 3)
>

Ok I will split this changes as per your suggestion.

> > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 2eb79a4d15ff ("ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board")
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes from previous patch.
> >
> > Fix the subject and commit message as per Martin's request
> >  --Add the signal name in the comment
> >  --Replace vbus-supply with phy-supply linking the power supply to phy node as pointed by Marine
> >    which a PWREN signal in the USB_HOST controller (usb1)
> >
> > USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
> >    phy-c1108820.phy.1         2                                 0mA     0mV     0mV
> >    phy-c1108800.phy.0         2                                 0mA     0mV     0mV
> > ---
> >  arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 58669abda259..bfa472a679d9 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -83,6 +83,22 @@
> >                 regulator-max-microvolt = <5000000>;
> >         };
> >
> > +       usb_vbus: regulator-usb-vbus {
> > +               compatible = "regulator-fixed";
> > +
> > +               regulator-name = "USB_VBUS";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +
> > +               vin-supply = <&p5v0>;
> > +
> > +               /*
> > +                * signal name from schematics: PWREN
> > +                */
> > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +       };
> > +
> >         tflash_vdd: regulator-tflash_vdd {
> >                 /*
> >                  * signal name from schematics: TFLASH_VDD_EN
> > @@ -295,8 +311,18 @@
> >         pinctrl-names = "default";
> >  };
> >
> > +&usb0_phy {
> > +       status = "okay";
> > +       phy-supply = <&usb_vbus>;
> I'm not sure whether phy-supply is correct here
> with the PHY framework and the dwc2 controller regulators can be set as:
> - phy-supply (inside the PHY node)
> - vbus-supply (inside the dwc2 controller node)
>
> phy-supply is always enabled when the PHY is enabled.
> vbus-supply is smarter: it's enabled whenever the controller is in
> host mode (or OTG detects hosts mode), but disabled in
> device/peripheral mode
>
phy-supply enables the power per port power setting which get on when
device is connected.

vbus-supply controls the D+ D- signal during high seed data transfer.

I have check this setting dr_mode="peripheral" it did not work out for me.
Initial it supper the warning but it was not the correct solution.

> as far as I understand we don't want to send power to the "Micro USB"
> port if we're in device/peripheral mode.
>
>
> Regards
> Martin

Best Regards



-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

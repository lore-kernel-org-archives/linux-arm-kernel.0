Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA0C26640
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:44:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545BA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b1ce2QiT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGhFNI6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545BA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/xBFc1xqm99jTtpil8jWhgspEgdZ/gVEI5bsF0/hBA=; b=b1ce2QiTuF6hlT
	Ms2uJNJw5slhGPd6c0v6ebZAKbvEK7nSfosACDNIuN0iakdQY8qAH+9p3/3YVv9U5POvV8Rg7nhoQ
	V3aO3lhjoLJ7831YwJz7/ct349PqxSaFOfs4bl+Sx3Vqvlsfxl03BxsDw4w7wfsSyqDX4Y6Z8W+85
	PECqCiZzbk1yMvrxmrOvRx9araGcopatGDpEjTlwYglB6pVhU2hVGmYybR+EAYwC1an+s6JKQUx3E
	FXv+fEPEx3pRx5orAAlp6lcgEhx6wSittPDfcjaU/6qNOHmHVpqk6i4F/W8+IOvsHl9K0M3LactS/
	JWiLNICWRTFqAR3CIymw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glI5H-0004Xz-6G; Sun, 20 Jan 2019 18:44:39 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glI5B-0004XD-K7; Sun, 20 Jan 2019 18:44:38 +0000
Received: by mail-oi1-x241.google.com with SMTP id j21so12876777oii.8;
 Sun, 20 Jan 2019 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gQsmGb1YRsLxdDZf2IXmLQaC4Iit+gXYd0AXQqBzsUw=;
 b=PGhFNI6/9ymWDFeZDJDX1spuiIKY0OaxrIH0qYIOiig3DQ3fuegceGX5/1iws1uzps
 m5e9gnQXPceENJWIfJ11cKBD1tQw638lGse1NzAz5CZS/gaQTSck4R665VCgOIfcKOrM
 LPWkJfnGmQvOXIc3SscPM19xps6+A1eeVhdnGwqycPJn9V1OwAOBLKYxo39CTc3IfxjM
 n7sCCkOgMaaJYB+s3tU4nx55dwmDZOqD9j7sBtYhyFvMjoe0cFWTad9nOMaaccmnujXK
 0TebbR6uPPrMJ0Z27mw5Hr1ynn7PRJ8IxEyuC/223ZgtLdtYMHN/9x6LjfFkqoHUlMwP
 AeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gQsmGb1YRsLxdDZf2IXmLQaC4Iit+gXYd0AXQqBzsUw=;
 b=VfscwDr/n6XhQ4w+P1yD709fObUpajU3ekW4EnZ7KqHepD4GKt9VHf3/mnlxkCQ4Sv
 XDGv66w/vxPUXKAb2xAal6SGOudohtvmoHa8ne8WQHuKcotEN0mhijfQpkqBvmsUw0/f
 S8u563ITRpf5JyCwXNJLyWdK2ErXnK1Uqoo0BG9HP0HUc8p84PUfG3IC/kUwZZixdADj
 aIe80RPfnpf5fU8UXmACClCjZEcejz4aE5WIAowbZowHNN8T1v+VKyE7IhaANAk1R7Yy
 Wls0w05cGoAGvjfq+ZufxUY7foYl9W46ipKXGyBccpsaab9P4Vp3/mFkTcuQAeaW2+nA
 YXCQ==
X-Gm-Message-State: AJcUukfRnRcfzcnROB6BWK12lZEL6gpAg70W2f3OnWBXR+rcnf5o07PQ
 UL0eCslMJOVlDEXzaErxZ/J1l1L5DlI74UtvxXQ=
X-Google-Smtp-Source: ALg8bN6Yuuhwt5IlhBG0oKTVso9J2h8Vm1A95vUdhOiaBOjha8W1PN8dvLMaQnEH93bjhr1CY0AgEa0CQAhVA8XUbtg=
X-Received: by 2002:aca:5d57:: with SMTP id r84mr3952894oib.243.1548009867634; 
 Sun, 20 Jan 2019 10:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com>
 <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
In-Reply-To: <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 21 Jan 2019 00:14:15 +0530
Message-ID: <CANAwSgQNNRqr3rZRgr71iy7+0zuuYykd+4-1W3LB+Voux6KioQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_104433_691868_4FA4D100 
X-CRM114-Status: GOOD (  30.21  )
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
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

Thanks for your review comments.

On Sat, 19 Jan 2019 at 03:59, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> thank you for this patch!
>
> On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add missing vbus-supply link to phy controller for usb_phy0
> > and usb_phy1 nodes, this changes fixed the power issue
> > on usb ports usb, changes help fix usb reset warning.
> I trust you on the fact that GPIOAO_5 controls VBUS of USB0 and USB1
>
> to me the schematics are not 100% clear or I'm bad at interpreting them:
> - I'll refer to odroid-c1+_rev0.4_20150615.pdf
> - page 1 lists GPIOAO.BIT5 as input for the PWREN signal of the
> USB_OTG controller (usb0)
> - page 1 also shows a PWREN signal in the USB_HOST controller (usb1)
> but not it's input
> - based on your patch I assume that PWREN is the same signal for both
> USB controllers
>
As per the schematics odroid-c1+_rev0.4_20150615.pdf

It seem that their  vbus setting for *OTG* port. *Bus 01.Port 1* using
*GPIOAO.BIT5* gpio
But we also need set power supply for *USB_B* port. *Bus 02.Port 1* ?
I don't know but I will try to find solution.
We need to enable some bit in phy driver ?

> > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> you already split your original patch into two, however I suggest
> splitting these patches differently:
> - this one (personally I would choose "ARM: dts: meson8b: odroidc1:
> fix USB VBUS supplies" as title), which contains the Fixes tag, adds
> the "usb_vbus" and references it in the "usb0" and "usb1" nodes
> - enables usb0_phy and usb0 as part of your second patch (I would call
> that "ARM: dts: meson8b: odroidc1: enable the OTG capable USB
> controller")

Ok I will fix this as per you suggestion in the next version.

>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Rebased on Kevin's amlogic/v5.0/fixes branch
> >
> > [alarm@archl-c1t ~]$ lsusb -t
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > [alarm@archl-c1t ~]$
> > [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> > Couldn't open device, some information will be missing
> > Bus 001 Device 003: ID 1b71:0056 Fushicai
> >     MaxPower              500mA
> > Couldn't open device, some information will be missing
> > Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
> >     MaxPower               30mA
> > Couldn't open device, some information will be missing
> > Couldn't open device, some information will be missing
> > Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
> >     MaxPower              100mA
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >     MaxPower                0mA
> > ---
> >  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 0f0a46ddf3ff..a49a8509b288 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -83,6 +83,19 @@
> >                 regulator-max-microvolt = <5000000>;
> >         };
> >
> > +       usb_vbus: regulator-usb-vbus {
> please add a comment here with some details about the regulator and
> add a hint that the signal in the schematics is called "PWREN"
Ok I will add this comment in the next patch.
>
> > +               compatible = "regulator-fixed";
> > +
> > +               regulator-name = "USB_VBUS";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +
> > +               vin-supply = <&p5v0>;
> > +
> > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +       };
> > +
> >         tflash_vdd: regulator-tflash_vdd {
> >                 /*
> >                  * signal name from schematics: TFLASH_VDD_EN
> > @@ -293,8 +306,18 @@
> >         pinctrl-names = "default";
> >  };
> >
> > +&usb0_phy {
> > +       status = "okay";
> > +       vbus-supply = <&usb_vbus>;
> > +};
> > +
> >  &usb1_phy {
> >         status = "okay";
> > +       vbus-supply = <&usb_vbus>;
> > +};
> > +
> > +&usb0 {
> > +       status = "okay";
> >  };
> I believe there's a problem with the usb/usb_phy nodes here. on my
> Odroid-C1 this results in:
> # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
>    USB_VBUS                      0    0      0 unknown  5000mV     0mA
>  5000mV  5000mV
> (open count is 0)
>
> if I move "vbus-supply" to the "usb1" node (just as an example) then I get:
> # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
>    USB_VBUS                      1    1      0 unknown  5000mV     0mA
>  5000mV  5000mV

Sorry for the mixing the vbus-supply node.

After fix the phy driver code and dts changes I am getting this changes.
# cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
    USB_VBUS                      1    2      0 unknown  5000mV
0mA  5000mV  5000mV

Now I am able to enable both *Bus 01.Port 1* and *Bus 02.Port 1*

# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M

But not usb device are getting enable on *Bus 01.Port 1*

>
> unfortunately neither your original patch nor the modified version
> seem to enable USB VBUS on my Odroid-C1.
> I have documented my findings already back in December, see "USB
> issues on Odroid-C1" [0]
> help on that would be highly appreciated :)
>
> on which board revision have you tested this patch?
>

I have with me for testing

ODROID-C0 REV 0.4 20151217
ODROID-C1+ REV 0.4 20150615 ----> current testing on
ODROID-C1+ REV 0.4 20160226

>
> Regards
> Martin
>
>
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009451.html

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

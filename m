Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FEC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAD620880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="keekRKPM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xe3BJ8s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAD620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95qRSRD1B4rgCytH1IdU3ScfN3H85QF3KQprNn4BNww=; b=keekRKPMHbslSA
	famo6OMA7H8lP2PyuK0p33Mxec4zaqc3FQXYCsmNPLXZmqxL7eyO8MARRW6M5HUIad7ALE1v3Lsj9
	GRbGZnaJ5n5vQruBf0dTD7DLhW1EtLmtYxqperMykptko/Pjazb3s81rJ7WX1Rf9uwNYO51KfBowV
	3oCNLiIAgBSjzZFhxtZlooHA0RnZgL342YSqd/biEHzyqsnnDuUrOnu/8bH8zZbNVnT05R+mLnpng
	X901e9s/rXuEdd8vDxyl/JaUQ2aMp2TVN90XvnI56tk89wB2iCZQTa03CH10rZbx19YviSrXQFmXm
	E+wkp/ruEDti8G2R3U/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glL0U-0005eI-T6; Sun, 20 Jan 2019 21:51:54 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glL0P-0005dc-DA; Sun, 20 Jan 2019 21:51:53 +0000
Received: by mail-ot1-x342.google.com with SMTP id s5so18970300oth.7;
 Sun, 20 Jan 2019 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MdlFd3vrS8nX47E6WmbowZkDm4Z7yx1r34PEVRp+sr0=;
 b=Xe3BJ8s/rZ4jicNb2wKnERRdO2mVmJ4rbyKIXGIGTLeU5+REooKOghj6Gq4mzpLnUE
 yO1QsrgEzKf1yIEy2amsH8jGuiowrJe5PQHwD799yOucuMUjT190DiCGzro010whg5pk
 feoF4FffL6+jHthGJ+3YRm5KhTH5qArdzxF1+MI2xhn3SR3hA6gENLb4RxDIfhyugsbf
 UWOcMXlms80ZM1X0TFAJllcKFil3e18soqNEHho7Ia5eW0JomWTVaEvdvWo3N2p+xDbG
 Z/K4BAeWOdUusilgnqWRPvBi4ip8FtULwiuNwrMC4EHcX78bV+8t4NWQ8klGKkhFNRxK
 lL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MdlFd3vrS8nX47E6WmbowZkDm4Z7yx1r34PEVRp+sr0=;
 b=B4Gr6HVe75B1XetaXocMZeb3gaaZHhw2PdoE6JyLfAqWBcC7QALcsDyfCahdU5Mv4C
 19NRz6UQFigTZalM2HOxw5SSdsUtBd9w+YI5oPnqKNy8Q6hhICY+opNrv6mVQhJGxhaP
 cI9rucydfUFgvfFC+v+33oNKOZ9CD/EMeqSGHBx8XW74Wnvozc5kzjuNiUKX/IcRTU9W
 yG3WMLA7kHdUePN5ma6hQ5DxcW5uwCfBSS6WWvccTDeUnXEZBWwIX1f3v7hX40jmYEiC
 yRAzqa/Tol7h59KgLZ3U397TNjl81FMbbuZDh3TIdIXlDawu5RoX4HNrVItWE+jq+3BI
 MSrQ==
X-Gm-Message-State: AJcUukeX3P4UTDHYCjj2Um7PlA9y1G3COVR6hiqyWhDav6WHpYfFx9DK
 3mYHbX5PNNPg6LrpZQ+U7eaJDOOSwx0JHxXJ2mo=
X-Google-Smtp-Source: ALg8bN6mqPl/U7e7Nnn2KbXmdeKsEmPwwaPQ9Pj7TdqfoV5X1Wtx1+lKx/iu9QESuQ3N2R4QUexG0tSrPR78HuRKJ0c=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr18782381otl.342.1548021107636; 
 Sun, 20 Jan 2019 13:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com>
 <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
 <CANAwSgQNNRqr3rZRgr71iy7+0zuuYykd+4-1W3LB+Voux6KioQ@mail.gmail.com>
In-Reply-To: <CANAwSgQNNRqr3rZRgr71iy7+0zuuYykd+4-1W3LB+Voux6KioQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 20 Jan 2019 22:51:36 +0100
Message-ID: <CAFBinCCXufowepJaHgkPwhhNrogXDP-0x0ZS09OGCM=ua-=5MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_135149_446615_17B82F71 
X-CRM114-Status: GOOD (  37.36  )
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

Hi Anand,

On Sun, Jan 20, 2019 at 7:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> Thanks for your review comments.
>
> On Sat, 19 Jan 2019 at 03:59, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > thank you for this patch!
> >
> > On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Add missing vbus-supply link to phy controller for usb_phy0
> > > and usb_phy1 nodes, this changes fixed the power issue
> > > on usb ports usb, changes help fix usb reset warning.
> > I trust you on the fact that GPIOAO_5 controls VBUS of USB0 and USB1
> >
> > to me the schematics are not 100% clear or I'm bad at interpreting them:
> > - I'll refer to odroid-c1+_rev0.4_20150615.pdf
> > - page 1 lists GPIOAO.BIT5 as input for the PWREN signal of the
> > USB_OTG controller (usb0)
> > - page 1 also shows a PWREN signal in the USB_HOST controller (usb1)
> > but not it's input
> > - based on your patch I assume that PWREN is the same signal for both
> > USB controllers
> >
> As per the schematics odroid-c1+_rev0.4_20150615.pdf
>
> It seem that their  vbus setting for *OTG* port. *Bus 01.Port 1* using
> *GPIOAO.BIT5* gpio
that matches my interpretation of the schematics

> But we also need set power supply for *USB_B* port. *Bus 02.Port 1* ?
> I don't know but I will try to find solution.
I assume we also have to enable VBUS for the host only port, but I
don't know how

> We need to enable some bit in phy driver ?
I'm not aware of any bit in the PHY driver which can toggle VBUS

(trying to be creative here) maybe the GPIO is incorrectly configured
to pull up or down?
if you want me to compare anything: there's some Armbian image (where
the USB host ports are working fine) on the eMMC of my Odroid-C1 so I
can get you the values you're looking for

> > > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > >
> > > Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> > you already split your original patch into two, however I suggest
> > splitting these patches differently:
> > - this one (personally I would choose "ARM: dts: meson8b: odroidc1:
> > fix USB VBUS supplies" as title), which contains the Fixes tag, adds
> > the "usb_vbus" and references it in the "usb0" and "usb1" nodes
> > - enables usb0_phy and usb0 as part of your second patch (I would call
> > that "ARM: dts: meson8b: odroidc1: enable the OTG capable USB
> > controller")
>
> Ok I will fix this as per you suggestion in the next version.
>
> >
> > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > Rebased on Kevin's amlogic/v5.0/fixes branch
> > >
> > > [alarm@archl-c1t ~]$ lsusb -t
> > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> > >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> > >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> > >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > > [alarm@archl-c1t ~]$
> > > [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> > > Couldn't open device, some information will be missing
> > > Bus 001 Device 003: ID 1b71:0056 Fushicai
> > >     MaxPower              500mA
> > > Couldn't open device, some information will be missing
> > > Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
> > >     MaxPower               30mA
> > > Couldn't open device, some information will be missing
> > > Couldn't open device, some information will be missing
> > > Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
> > >     MaxPower              100mA
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > >     MaxPower                0mA
> > > ---
> > >  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > index 0f0a46ddf3ff..a49a8509b288 100644
> > > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > @@ -83,6 +83,19 @@
> > >                 regulator-max-microvolt = <5000000>;
> > >         };
> > >
> > > +       usb_vbus: regulator-usb-vbus {
> > please add a comment here with some details about the regulator and
> > add a hint that the signal in the schematics is called "PWREN"
> Ok I will add this comment in the next patch.
> >
> > > +               compatible = "regulator-fixed";
> > > +
> > > +               regulator-name = "USB_VBUS";
> > > +               regulator-min-microvolt = <5000000>;
> > > +               regulator-max-microvolt = <5000000>;
> > > +
> > > +               vin-supply = <&p5v0>;
> > > +
> > > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > > +               enable-active-high;
> > > +       };
> > > +
> > >         tflash_vdd: regulator-tflash_vdd {
> > >                 /*
> > >                  * signal name from schematics: TFLASH_VDD_EN
> > > @@ -293,8 +306,18 @@
> > >         pinctrl-names = "default";
> > >  };
> > >
> > > +&usb0_phy {
> > > +       status = "okay";
> > > +       vbus-supply = <&usb_vbus>;
> > > +};
> > > +
> > >  &usb1_phy {
> > >         status = "okay";
> > > +       vbus-supply = <&usb_vbus>;
> > > +};
> > > +
> > > +&usb0 {
> > > +       status = "okay";
> > >  };
> > I believe there's a problem with the usb/usb_phy nodes here. on my
> > Odroid-C1 this results in:
> > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> >    USB_VBUS                      0    0      0 unknown  5000mV     0mA
> >  5000mV  5000mV
> > (open count is 0)
> >
> > if I move "vbus-supply" to the "usb1" node (just as an example) then I get:
> > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> >    USB_VBUS                      1    1      0 unknown  5000mV     0mA
> >  5000mV  5000mV
>
> Sorry for the mixing the vbus-supply node.
>
> After fix the phy driver code and dts changes I am getting this changes.
> # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
>     USB_VBUS                      1    2      0 unknown  5000mV
> 0mA  5000mV  5000mV
>
> Now I am able to enable both *Bus 01.Port 1* and *Bus 02.Port 1*
>
> # lsusb -t
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
so this is the host-only controller (usb1) and it's working fine for
you - very nice!

> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>
> But not usb device are getting enable on *Bus 01.Port 1*
so you have something plugged into the OTG capable controller (usb0)
using an OTG cable?
I've not tried this before on my Odroid-C1 because I'm using the micro
USB connector to power the board

do you get VBUS (maybe you have a USB thumb drive with an LED which
lights up when you connect it)?
do you get any errors or warnings from the dwc2 driver during boot?

> >
> > unfortunately neither your original patch nor the modified version
> > seem to enable USB VBUS on my Odroid-C1.
> > I have documented my findings already back in December, see "USB
> > issues on Odroid-C1" [0]
> > help on that would be highly appreciated :)
> >
> > on which board revision have you tested this patch?
> >
>
> I have with me for testing
>
> ODROID-C0 REV 0.4 20151217
> ODROID-C1+ REV 0.4 20150615 ----> current testing on
I have the exact same Odroid-C1+ board revision
this is my u-boot version:
U-boot-00000-gb7b8dc2-dirty(odroidc@b7b8dc21) (Sep 01 2017 - 01:18:22)
-> b7b8dc21 is the lastest commit of the hardkernel odroidc-v2011.03
u-boot branch at the time of writing


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

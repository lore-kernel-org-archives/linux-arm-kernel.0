Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F7C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0794B2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3inxbTu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AGUyB6ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0794B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a5M7tHi/c9kMjteBZr9Ep+H1BfUXxa0p+BmnAbBi9u0=; b=J3inxbTuS9AhDt
	JZ24m7zA1JpaECnhMu7MyqP7q4tH6hea8MUAAuziVepZIXvf2+Y/o5zoYzJrl/4I58vDDkJED8bFO
	voWA7JDmK4/CZq53+DRPzMshBLlp1ymRFOFgn7akegzAsuYQ0RpqLHvxgBMRo2hKlHZK9NoFnW7lb
	p4rUa72YU25iSvVpG+WCN2S78UqSjxbzNuNzxNMKtNIhknWj0uK+bcI6KziMYFGvLhiQveENjleG7
	cck1IGMhj0rEIygO+21IJixR2yiYvSCW1Yswn8pK2FCVEaQHFg5f4eO1Vg9KjCjMQI8wjCf28AUUB
	QuzvePnBniuJsS6CmSeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkoz-0004fR-EW; Mon, 04 Feb 2019 20:26:25 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkoo-0004Uw-PC; Mon, 04 Feb 2019 20:26:18 +0000
Received: by mail-ot1-x342.google.com with SMTP id i20so2135680otl.0;
 Mon, 04 Feb 2019 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DY0gPJjBNf77VAs41DOXSaN/jFf2cz+xZhibHQ04Z0k=;
 b=AGUyB6ZHqTLMXm69D0/bPqMTZR4Znm3wpS61YS2a/oTZTx07V0O/dpdgSozIf4+9dz
 eYyHwAYikUHLCyZO8/XQ+F8fDhJ5B3mzZ8iC51dwtkH6NGNwY3tbPm5Wssj3aFk54ELf
 I0VFOnSqt3DhsH9Wn7pJdswoAcIh6nOOtfsjOC2WUvJLwh9KA/FeiU3KNnNKh6GgUjqK
 O73cbWI6NRFKmhlPFjP9AE6wOZwcaAKci/4695BYvdL2Q8OeljBFiYLuuWVVJ+Qn2gWS
 wkI2OjLD7jPG9/mkaoGPtiZmBXVJQPBU5r5FpxyGnDx2CXG9wK8fo7l4A0yauj8XGTX6
 gDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DY0gPJjBNf77VAs41DOXSaN/jFf2cz+xZhibHQ04Z0k=;
 b=M0+ZgFiLqnEymrJbfSgzDHqnArIQp3TApGeuVOOcVaEeaMzMLopk8qqMneSeq/QlWL
 SIV4HUNbfgHTotOnPFaA3ioqKeaL3rW7+ksxT3pLmB01tqan3zUW7tBfoO6KTqtq49SH
 TxSRKn44s+4/fAF4Q8Y2jRIYsA81jib2zqVJGFLzbwFK+jsFrvBdtmh+UM+cWOICiCrm
 HVDHncmjNfgUd6UmLkFxa4w1Zl6U+NfHmN3TPqjkvxC1dM4K36mY/vvbSgHM4bDvF+rh
 HedS1afjRDcLiTRX8XRsGKWAbCgPAnYBsga/39F/2usz8ThNq6e/6Pn1pDmmdGy3vW2/
 HMCA==
X-Gm-Message-State: AHQUAuZXz7Y8SdKRhK9XvCE9AsVTTi9Cwm6nPBJaxNC/rJzdeavALS+T
 x5/fxtg9xGaTHx8CcwPjgwYZLImco4ED21VfIjA=
X-Google-Smtp-Source: AHgI3IYFzXVMuPIcyy3QoHxSGlBmRZzVlccedqISMuXE2hOKEB2CDHAfI5U83L17oOmJNoc9QjJIY4ZXxGr+fdVI48E=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr666511otg.308.1549311973807;
 Mon, 04 Feb 2019 12:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
 <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
 <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
In-Reply-To: <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 21:26:02 +0100
Message-ID: <CAFBinCD_O7FEX5iLyo2BzqE1KcrmATaZMMq5pFr-Q7wnRBPziw@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_122614_827203_4464368C 
X-CRM114-Status: GOOD (  34.98  )
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

Hi Anand,

On Mon, Feb 4, 2019 at 9:03 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> Thanks for your review comment.
> Please find my comments below.
>
> On Mon, 4 Feb 2019 at 18:51, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Meson8b support two USB phy controller, one with otg port and
> > > other usb host controller. USB OTG controller ie. otg port can
> > > be used to power on board or host port for usb device.
> > > Changes enable usb otg host controller when dr_mode is set to otg.
> > can you please add a sentence explaining *why* this allows enabling USB OTG?
> >
> > > Currenly otg port can be used to power on the board.
> > typo, should be "Currently"
>
> Ok I will fix this next version.
>
> >
> > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > New patch in this series.
> > > --TOTO enable OTG port to work as host.
> > > --Currently we can power on the board from this OTG port.
> > >
> > > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> > >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> > >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> > >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > > ---
> > >  drivers/phy/amlogic/phy-meson8b-usb2.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > index 9c01b7e19b06..1333c77e9172 100644
> > > --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > @@ -109,6 +109,7 @@
> > >
> > >  #define RESET_COMPLETE_TIME                            500
> > >  #define ACA_ENABLE_COMPLETE_TIME                       50
> > > +#define DCD_ENABLE_COMPLETE_TIME                       10
> > >
> > >  struct phy_meson8b_usb2_priv {
> > >         void __iomem            *regs;
> > > @@ -188,6 +189,20 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
> > >
> > >                 udelay(ACA_ENABLE_COMPLETE_TIME);
> > >
> > > +               if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
> > > +                       REG_ADP_BC_ACA_PIN_FLOAT) {
> > > +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> > > +                       clk_disable_unprepare(priv->clk_usb);
> > > +                       clk_disable_unprepare(priv->clk_usb_general);
> > > +                       return -EINVAL;
> > > +               }
> > > +       } else if (priv->dr_mode == USB_DR_MODE_OTG) {
> > > +               phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
> > > +                                          REG_ADP_BC_DCD_ENABLE,
> > > +                                          REG_ADP_BC_DCD_ENABLE);
> > where did you take this from?
>
> As per the schematic it's otg phy,
> I study the code to enable "host" mode for phy1 and on similar line I
> tried to enable otg phy.
dragons ahead!
if you want to work on OTG support then I'm fine with this (from time
to time people ask about this on IRC)!
But beware that this needs more than a few changes to the PHY driver.

Amlogic's code uses a timer to poll whether the port is in HOST or
DEVICE mode and switches the mode accordingly, see [0]
however, this is not just limited to the PHY but it also requires
switching the dwc2 registers

personally I would start with getting device / peripheral mode working for usb0.
if you're lucky the PHY driver will work without any changes and you
only need to set the correct dr_mode along with the g-* properties.

> this changes will come into effect when we set dr_mode="otg" in dts.
> but it do not enable this as host port.
>
> *Second thought this enable DCD which seem the be wrong. Thanks for porting out*
> We could set this to 0 at initial state for now and it will work as it should.
> I will send the correct fix later.
>
> > $ grep -iR DCD arm-src-kernel-2015-01-15-321cfb5a46/drivers/amlogic/usb/dwc_otg/310/
> > -> I only find code which clears REG_ADP_BC_DCD_ENABLE (your patch sets it):
> >   adp_bc.b.dcd_enable = 0;
>
> This usb port act as a changer port but it also depend on the how this
> port is tuned to various states as shown below.
>
> Standard Downstream Port (SDP) is a downstream port that complies
>               with the USB 2.0 or USB 3.0 definition of a host or hub.
> Charging Downstream Port (CDP) is a downstream port that complies
>               with the USB 2.0 or USB 3.0 definition of a host or a hub.
> Dedicated Charging Port (DCP)  is a downstream port on a device
>               that outputs power through a USB connector.
>
> We cannot observe this now because this behave like a states machine which
> is possible handled both in kernel driver and u-boot of Amlogic.
> As per schematics this (page 7)  we have a external jumper set to
> control the power path of the port.
>
> Odroid Wiki also says so.
> [0] https://wiki.odroid.com/odroid-c1/hardware/otg_power_enable
this seems hard to implement, because the same wiki page also states:
"If your C1+ PCB is previous version, you need to desolder the R94 as
described in this link."


Regards
Martin


[0] https://github.com/endlessm/linux-meson/blob/0672f0b61eb92ba63c91d858a678d2c3a0bba06a/drivers/amlogic/usb/dwc_otg/310/dwc_otg_driver.c#L716

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

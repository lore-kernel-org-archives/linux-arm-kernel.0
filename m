Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D8C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AD72081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SuiCgF7T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gshQC59i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AD72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x40Ty6REk9TN70dmwTyfaemDJlCp7j52RbZYe+JCnws=; b=SuiCgF7Two0Wmr
	hVNzuxQXDMIrBML/A0JuxbBb7QGb4IUTMxOmRRwZoUeRHP/JOfod2qPohGq0OobigRyVo945zJjyn
	nt/8cB/CPkAzhJU+JllqIbUkbbnzTWMdStZs+FeHak3oMFZvMycpC+qv99OdBoNyecj/uOfnz7ShA
	OkUOk7W14+f0/YaiUwxsxL4wf/818IsOxLW5QL4cgO0EBE2Gvx2P6FUiEFOOh8fPaJblTvH23GYqq
	GvKiwrJjBfwshZ6u0W3UnCRy9/iwb5wcnnRvOHO0xxsy/dVQrrABPOrPSD74M6jU7uRa8/oE5/Szv
	bWkm5ZzL5b6EZp6hZvBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkSQ-0001a6-Eg; Mon, 04 Feb 2019 20:03:06 +0000
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkSN-0001Zh-4g; Mon, 04 Feb 2019 20:03:04 +0000
Received: by mail-ot1-x330.google.com with SMTP id a11so1896125otr.10;
 Mon, 04 Feb 2019 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dlSy7ECNsSOP0ebJimbZXxzz0cJdouA4zM6hfDf3yDI=;
 b=gshQC59iQ0pgScLv8PD958XLzI0YMkfEt8du66Gke2M8dV8J7Kiz6APAiZWwwTo3nf
 H3rGsL/Sbc7a0/Wlh+0eencU1PllvoJAKxR+9QHK3XTrsee6tn24qGWe4c3fDOsQGy/A
 OGBt0grCE7VRH3pkxlaXtu8Ua8bjUiBWUVzoXHMYpFIhI7MRQHdo96uwMIHOibhY34A1
 S0AKcIbr3agOwW1XEnHut+PnNXjBG/AdvPA2nGCcdp8yNwaG2/It6gprgSKG7+cNWZjC
 L2GO49Tbi19IdnUsCeVlRIQwbS8nwT0yJkVS/DCk/0T8QZ8XM/6AlPmQbwDLi1yd0kTJ
 ijqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dlSy7ECNsSOP0ebJimbZXxzz0cJdouA4zM6hfDf3yDI=;
 b=PKz8FhxCuUYrVPu6oRdLzbenveTr8lyla+Z8ZZs5dy6JMU5aMEHaTb0nyU2n9TwWMj
 ZOjIrPo9RIEbibGeEMQO+GQUDo80XZ9C7kdsGZgiqqmt3kTQyF6rglBoa+PEKrM7S5JB
 5BN+An81XpG9g98FL6TpK7sw7Bo+rHJy61Bi22ul98WITmFvWMO1rQE/zOIm++cqTMS+
 RBna6XdeZF3eSqNUJY62QtRGjgwZM+wmq4tShkVQmEFerQ2B8QtSl7bnDe/s5GTqhZrJ
 2tGmXeVje08hm4lLfTuIJxjEJmsG6FpnT1yKekP+B9fX1BRGiyGmKWdpvhyDEyIJlKO6
 bBrw==
X-Gm-Message-State: AHQUAub0SBgMJAnbF5Crw1c9JTugKqicC3zXfn9nTqLA7j2tPQ5PhhWo
 GMDD1tE7/R6ZUDeX1mGgBbHEVmS8ouM/jy3fZtI=
X-Google-Smtp-Source: AHgI3IYC1aeGh1mhE5emDQfTD1PoOgBc+rJ9MT3+lnlFnyHK2CXmOwg71wB1WCbZlHQSjjqPZ1RmE8pJ2K6DskPA+ws=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr618591ota.76.1549310579846; 
 Mon, 04 Feb 2019 12:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
 <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
In-Reply-To: <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 5 Feb 2019 01:32:45 +0530
Message-ID: <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_120303_233505_4392DDC3 
X-CRM114-Status: GOOD (  27.44  )
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

Thanks for your review comment.
Please find my comments below.

On Mon, 4 Feb 2019 at 18:51, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Meson8b support two USB phy controller, one with otg port and
> > other usb host controller. USB OTG controller ie. otg port can
> > be used to power on board or host port for usb device.
> > Changes enable usb otg host controller when dr_mode is set to otg.
> can you please add a sentence explaining *why* this allows enabling USB OTG?
>
> > Currenly otg port can be used to power on the board.
> typo, should be "Currently"

Ok I will fix this next version.

>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch in this series.
> > --TOTO enable OTG port to work as host.
> > --Currently we can power on the board from this OTG port.
> >
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > ---
> >  drivers/phy/amlogic/phy-meson8b-usb2.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > index 9c01b7e19b06..1333c77e9172 100644
> > --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> > +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > @@ -109,6 +109,7 @@
> >
> >  #define RESET_COMPLETE_TIME                            500
> >  #define ACA_ENABLE_COMPLETE_TIME                       50
> > +#define DCD_ENABLE_COMPLETE_TIME                       10
> >
> >  struct phy_meson8b_usb2_priv {
> >         void __iomem            *regs;
> > @@ -188,6 +189,20 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
> >
> >                 udelay(ACA_ENABLE_COMPLETE_TIME);
> >
> > +               if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
> > +                       REG_ADP_BC_ACA_PIN_FLOAT) {
> > +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> > +                       clk_disable_unprepare(priv->clk_usb);
> > +                       clk_disable_unprepare(priv->clk_usb_general);
> > +                       return -EINVAL;
> > +               }
> > +       } else if (priv->dr_mode == USB_DR_MODE_OTG) {
> > +               phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
> > +                                          REG_ADP_BC_DCD_ENABLE,
> > +                                          REG_ADP_BC_DCD_ENABLE);
> where did you take this from?

As per the schematic it's otg phy,
I study the code to enable "host" mode for phy1 and on similar line I
tried to enable otg phy.
this changes will come into effect when we set dr_mode="otg" in dts.
but it do not enable this as host port.

*Second thought this enable DCD which seem the be wrong. Thanks for porting out*
We could set this to 0 at initial state for now and it will work as it should.
I will send the correct fix later.

> $ grep -iR DCD arm-src-kernel-2015-01-15-321cfb5a46/drivers/amlogic/usb/dwc_otg/310/
> -> I only find code which clears REG_ADP_BC_DCD_ENABLE (your patch sets it):
>   adp_bc.b.dcd_enable = 0;

This usb port act as a changer port but it also depend on the how this
port is tuned to various states as shown below.

Standard Downstream Port (SDP) is a downstream port that complies
              with the USB 2.0 or USB 3.0 definition of a host or hub.
Charging Downstream Port (CDP) is a downstream port that complies
              with the USB 2.0 or USB 3.0 definition of a host or a hub.
Dedicated Charging Port (DCP)  is a downstream port on a device
              that outputs power through a USB connector.

We cannot observe this now because this behave like a states machine which
is possible handled both in kernel driver and u-boot of Amlogic.
As per schematics this (page 7)  we have a external jumper set to
control the power path of the port.

Odroid Wiki also says so.
[0] https://wiki.odroid.com/odroid-c1/hardware/otg_power_enable

>
> > +               udelay(DCD_ENABLE_COMPLETE_TIME);
> from Amlogic's code: DWC_MDELAY(T_DCD_TIMEOUT);
> while you are also using a delay of "10" the unit is different (your
> patch: us, Amlogic: ms)
>

This timeout is basically used in the state machine in the kernel and
u-boot to tune the phy
Not sure this changes will affect the phy power state.

>
> Regards
> Martin

Best Regards


-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51B9C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BA22184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ddxKFTGb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4vAf/5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BA22184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qzL1N3rLZ0l8T8VorWCKdIguYs2rkL3INPiHUF6wFoM=; b=ddxKFTGbCOLHQe
	7Kr2nVedDJfJOipNeQvsxU2CnGCHC53pleS5pvacbxHMsIUAILd+lkr40+YyJvf4DXOACAKppgvzj
	KaSX4HBMIGo9LAIne3kE3Asp5ZIZgl7fxtuEzhyDjpunaeSOqRzaeFMHiavaTsKddLLcpTRVMpcjv
	0mMgSOEAZ7adJrxxwZsEGvhuVaEHIksU/9A+X9rLwuUBRUWnEDf5VAjIG3JTlYycEc2KMgnHozjz2
	/hDcqqcAIGP9Esoir2ZuRQxlBul7TUpeqxONBD+n7ru7yg7vM9fK/rNWakska+S/zvSYgXy2AD0+N
	O5/rmmR+PE/MM8wzwgiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6m3-0002in-7Z; Tue, 05 Feb 2019 19:52:51 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6lz-0002iQ-FH; Tue, 05 Feb 2019 19:52:49 +0000
Received: by mail-ot1-x341.google.com with SMTP id w25so7805077otm.13;
 Tue, 05 Feb 2019 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7vbon4MDNXJCOjWAvhbJABQq10NsRYFFTcFyO7Kpt5Y=;
 b=g4vAf/5gUgO/hZxBhd3KHRUKmbaxJf77+CsG+eIorpTxXlWXoqdgI7mbrWDBtL+w98
 Pzsxx26WT+o8bgwhZGHg0N0LYksYSkzZFs5y0hi9UaXNGGiJckKkpXpCs/xQ7lKReEcR
 cMbBuRIf/moqgnWVVq5luKk9zD4JsXDA+k9iXSZ0WUcQMn4FqI/CAE8OCdMO04wytuBu
 edBe4tjgXEPmvDxs0fmrYlxAK7mzqHTdsOEFAQQr8wVsdxHp86ga4AYxPmQGW1j2YipB
 rKovfv9upuljxZGMNEJ1U2CIPHEab4DDfV14LjeqR9ZQrS8HTSpQPKjjOuITc+yi3n0A
 VvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7vbon4MDNXJCOjWAvhbJABQq10NsRYFFTcFyO7Kpt5Y=;
 b=bxC5La/iHcPrtjQUBLD8msb7X0NGyU1k9vaJvtlpd23Q/iwb4Os56p/fDNwjGzegpN
 FQeLcNi7pw57MDjZj8KMeYOMqnUv+EkgmF7yauSltWHe2jrIJivGp4KphQpStgj23DSp
 +WOoG+1NXNEg34UvrL1tatlhdvPJ9ONuz7YYh89hHuxdf0XQrLDscsRxqsOPTWMbfweN
 poV4jEUe/NbNby+GmRcIthCZO2yXiHrdH5NB+BkhfndMFUAzN/IvGK7W5eJkIbPy5aeO
 3QmtLlWL7HrVY7qBDA5F+X5McW9CfPFa9jwzUunLdMYu8w/hy5yLJ7Vg+f+3TiALRIXL
 YLFQ==
X-Gm-Message-State: AHQUAubn2RphBwysUtiO49lHOC/fW3Yfqq5h0yM7GUA4SV2iMRB5pCTU
 7WqjLTUCnW0J+pzZxZehJSevKCZU7DSr2Yip/8nidQ==
X-Google-Smtp-Source: AHgI3IazWPKINPlKZBfKsVyE+hyYfbJR7gYTYDwUOcUqKFtI9aGXKjmuThMLc7tsD7xkJRk0u75DhXZe1RD+QKLq/Ko=
X-Received: by 2002:aca:5b88:: with SMTP id p130mr3321927oib.96.1549396365355; 
 Tue, 05 Feb 2019 11:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
 <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
 <CANAwSgSQH2zta+tOcqnM3JPZ45XkqWEJAWOL3Do0Mnrbam8VSw@mail.gmail.com>
 <CAFBinCD_O7FEX5iLyo2BzqE1KcrmATaZMMq5pFr-Q7wnRBPziw@mail.gmail.com>
In-Reply-To: <CAFBinCD_O7FEX5iLyo2BzqE1KcrmATaZMMq5pFr-Q7wnRBPziw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 6 Feb 2019 01:22:33 +0530
Message-ID: <CANAwSgSh--pom9kmVBWejHwVHJNv2o4Ta93wabR3Ak=f3V4JbQ@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115247_539951_C44B83E3 
X-CRM114-Status: GOOD (  40.25  )
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

Thanks for your views.

On Tue, 5 Feb 2019 at 01:56, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 4, 2019 at 9:03 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin,
> >
> > Thanks for your review comment.
> > Please find my comments below.
> >
> > On Mon, 4 Feb 2019 at 18:51, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Anand,
> > >
> > > On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Meson8b support two USB phy controller, one with otg port and
> > > > other usb host controller. USB OTG controller ie. otg port can
> > > > be used to power on board or host port for usb device.
> > > > Changes enable usb otg host controller when dr_mode is set to otg.
> > > can you please add a sentence explaining *why* this allows enabling USB OTG?
> > >
> > > > Currenly otg port can be used to power on the board.
> > > typo, should be "Currently"
> >
> > Ok I will fix this next version.
> >
> > >
> > > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > New patch in this series.
> > > > --TOTO enable OTG port to work as host.
> > > > --Currently we can power on the board from this OTG port.
> > > >
> > > > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > > >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> > > >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> > > >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> > > >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> > > >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> > > >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > > > ---
> > > >  drivers/phy/amlogic/phy-meson8b-usb2.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > > index 9c01b7e19b06..1333c77e9172 100644
> > > > --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > > +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> > > > @@ -109,6 +109,7 @@
> > > >
> > > >  #define RESET_COMPLETE_TIME                            500
> > > >  #define ACA_ENABLE_COMPLETE_TIME                       50
> > > > +#define DCD_ENABLE_COMPLETE_TIME                       10
> > > >
> > > >  struct phy_meson8b_usb2_priv {
> > > >         void __iomem            *regs;
> > > > @@ -188,6 +189,20 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
> > > >
> > > >                 udelay(ACA_ENABLE_COMPLETE_TIME);
> > > >
> > > > +               if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
> > > > +                       REG_ADP_BC_ACA_PIN_FLOAT) {
> > > > +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> > > > +                       clk_disable_unprepare(priv->clk_usb);
> > > > +                       clk_disable_unprepare(priv->clk_usb_general);
> > > > +                       return -EINVAL;
> > > > +               }
> > > > +       } else if (priv->dr_mode == USB_DR_MODE_OTG) {
> > > > +               phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
> > > > +                                          REG_ADP_BC_DCD_ENABLE,
> > > > +                                          REG_ADP_BC_DCD_ENABLE);
> > > where did you take this from?
> >
> > As per the schematic it's otg phy,
> > I study the code to enable "host" mode for phy1 and on similar line I
> > tried to enable otg phy.
> dragons ahead!
> if you want to work on OTG support then I'm fine with this (from time
> to time people ask about this on IRC)!
> But beware that this needs more than a few changes to the PHY driver.
>
> Amlogic's code uses a timer to poll whether the port is in HOST or
> DEVICE mode and switches the mode accordingly, see [0]
> however, this is not just limited to the PHY but it also requires
> switching the dwc2 registers

Ok thanks for the input.

>
> personally I would start with getting device / peripheral mode working for usb0.
> if you're lucky the PHY driver will work without any changes and you
> only need to set the correct dr_mode along with the g-* properties.
>

Yes that should be the goal on getting working usb0 phy and otg port.
So for now we will drop this patch and disable the usb_phy0 mode in
dts for Odroid c2
in order to get ride of the power failed WARNING.

When we get the usb0 node to work again with good phy configuration and
tuning we can re-enable the nodes. I will try to look into this in the future.

Can you share your thought on this.



> > this changes will come into effect when we set dr_mode="otg" in dts.
> > but it do not enable this as host port.
> >
> > *Second thought this enable DCD which seem the be wrong. Thanks for porting out*
> > We could set this to 0 at initial state for now and it will work as it should.
> > I will send the correct fix later.
> >
> > > $ grep -iR DCD arm-src-kernel-2015-01-15-321cfb5a46/drivers/amlogic/usb/dwc_otg/310/
> > > -> I only find code which clears REG_ADP_BC_DCD_ENABLE (your patch sets it):
> > >   adp_bc.b.dcd_enable = 0;
> >
> > This usb port act as a changer port but it also depend on the how this
> > port is tuned to various states as shown below.
> >
> > Standard Downstream Port (SDP) is a downstream port that complies
> >               with the USB 2.0 or USB 3.0 definition of a host or hub.
> > Charging Downstream Port (CDP) is a downstream port that complies
> >               with the USB 2.0 or USB 3.0 definition of a host or a hub.
> > Dedicated Charging Port (DCP)  is a downstream port on a device
> >               that outputs power through a USB connector.
> >
> > We cannot observe this now because this behave like a states machine which
> > is possible handled both in kernel driver and u-boot of Amlogic.
> > As per schematics this (page 7)  we have a external jumper set to
> > control the power path of the port.
> >
> > Odroid Wiki also says so.
> > [0] https://wiki.odroid.com/odroid-c1/hardware/otg_power_enable
> this seems hard to implement, because the same wiki page also states:
> "If your C1+ PCB is previous version, you need to desolder the R94 as
> described in this link."
>
>
> Regards
> Martin
>
>
> [0] https://github.com/endlessm/linux-meson/blob/0672f0b61eb92ba63c91d858a678d2c3a0bba06a/drivers/amlogic/usb/dwc_otg/310/dwc_otg_driver.c#L716

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

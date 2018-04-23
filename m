From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 23 Apr 2018 15:33:10 +0800
Subject: [PATCH resend] usb: chipidea: Don't select EXTCON
In-Reply-To: <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
 <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20180420170126.732e093b@xhacker.debian>
 <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
Message-ID: <20180423153310.47a20e6d@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Apr 2018 09:35:54 +0000 Peter Chen wrote:

>  
> > >
> > > Sorry to reply late, are you really care 2KB code side? Since many
> > > users use EXTCON to handle vbus and id, it is hard just delete it. I
> > > could accept patch for your specific platforms, like:
> > >
> > > +	select EXTCON if !ARCH_XXXX  
> > 
> > The patch doesn't remove extcon support from chipidea driver.
> > I just want to not select EXTCON unconditionally, but let the users choose. If the
> > users need extcon, they could enable EXTCON themselves
> > 
> > I just searched all the dts in arch/arm/boot/dts and arch/arm64/boot/dts only the four
> > dts give extcon phandle to chipidea host, other users don't make use of it:
> > 
> > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > 
> > arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> > 
> > arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> > 
> > arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> >   
> 
> I see, but I do not want to break msm platforms. You may try to create Glue driver Kconfig
> entry for chipidea like dwc3, and let msm depends on EXTCON.

Got your points. Since multi_v7_defconfig has selected EXTCON, and
EXTCON_USB_GPIO(which depends on EXTCON) is enabled in arm64 defconfig, so
what about:

enable EXTCON explicitly in arm64 defconfig?
then add this patch?

Is it acceptable?

Thanks,
Jisheng

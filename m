From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 25 Apr 2018 01:47:42 +0000
Subject: [PATCH resend] usb: chipidea: Don't select EXTCON
In-Reply-To: <20180423153310.47a20e6d@xhacker.debian>
References: <20180419160144.0412a510@xhacker.debian>
 <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20180420170126.732e093b@xhacker.debian>
 <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <20180423153310.47a20e6d@xhacker.debian>
Message-ID: <HE1PR04MB14509924E386B58D5A95C4D38B8F0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > >
> > > The patch doesn't remove extcon support from chipidea driver.
> > > I just want to not select EXTCON unconditionally, but let the users
> > > choose. If the users need extcon, they could enable EXTCON
> > > themselves
> > >
> > > I just searched all the dts in arch/arm/boot/dts and
> > > arch/arm64/boot/dts only the four dts give extcon phandle to chipidea host, other
> users don't make use of it:
> > >
> > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > >
> > > arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> > >
> > > arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> > >
> > > arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> > >
> >
> > I see, but I do not want to break msm platforms. You may try to create
> > Glue driver Kconfig entry for chipidea like dwc3, and let msm depends on EXTCON.
> 
> Got your points. Since multi_v7_defconfig has selected EXTCON, and
> EXTCON_USB_GPIO(which depends on EXTCON) is enabled in arm64 defconfig,
> so what about:
> 
> enable EXTCON explicitly in arm64 defconfig?
> then add this patch?
> 

I am not sure if Qualcomm platforms use these, add Qualcomm guys to confirm it.

Peter

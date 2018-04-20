From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 20 Apr 2018 17:01:26 +0800
Subject: [PATCH resend] usb: chipidea: Don't select EXTCON
In-Reply-To: <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
 <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <20180420170126.732e093b@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

On Fri, 20 Apr 2018 01:38:42 +0000 Peter Chen wrote:

>  
> >  drivers/usb/chipidea/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig index
> > 785f0ed037f7..97509172d536 100644
> > --- a/drivers/usb/chipidea/Kconfig
> > +++ b/drivers/usb/chipidea/Kconfig
> > @@ -1,7 +1,6 @@
> >  config USB_CHIPIDEA
> >  	tristate "ChipIdea Highspeed Dual Role Controller"
> >  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD
> > && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
> > -	select EXTCON
> >  	select RESET_CONTROLLER
> >  	help
> >  	  Say Y here if your system has a dual role high speed USB
> > --
> > 2.17.0  
> 
> Hi Jisheng,
> 
> Sorry to reply late, are you really care 2KB code side? Since many users use
> EXTCON to handle vbus and id, it is hard just delete it. I could accept patch
> for your specific platforms, like:
> 
> +	select EXTCON if !ARCH_XXXX

The patch doesn't remove extcon support from chipidea driver.
I just want to not select EXTCON unconditionally, but let the users
choose. If the users need extcon, they could enable EXTCON themselves

I just searched all the dts in arch/arm/boot/dts and arch/arm64/boot/dts
only the four dts give extcon phandle to chipidea host, other users
don't make use of it:

arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi

arch/arm/boot/dts/qcom-apq8074-dragonboard.dts

arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts

arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts

Thanks

From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 13 Nov 2014 09:23:59 +0800
Subject: [PATCH 3/3] ARM: dts: vf-colibri: add USB regulators
In-Reply-To: <0bb62bdfc866f75977d01070d228ed4c@agner.ch>
References: <1415106430-6271-1-git-send-email-stefan@agner.ch>
 <1415106430-6271-4-git-send-email-stefan@agner.ch>
 <20141111141228.GB2704@dragon>
 <0bb62bdfc866f75977d01070d228ed4c@agner.ch>
Message-ID: <20141113012358.GN2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 04:51:16PM +0100, Stefan Agner wrote:
> >> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> >> index 2371760..79ccfe2 100644
> >> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> >> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> >> @@ -163,5 +163,17 @@
> >>  				VF610_PAD_PTD3__UART2_CTS		0x21a1
> >>  			>;
> >>  		};
> >> +
> >> +		pinctrl_usbh1_ext: gpio_usb_vbus {
> >> +			fsl,pins = <
> >> +				VF610_PAD_PTD4__GPIO_83			0x22ed
> > 
> > We used to know the GPIO usage by looking for the phandle reference to
> > the node.  But it doesn't work for VF610 case now.
> > 
> > I guess this is for usbh_vbus_reg usage?  It would be nice to have a
> > comment telling the usage of the GPIO.
> 
> Yeah its true, its assign is not required for Vybird. However, we could
> assign them anyway, it would even enforce correct pin setup from
> Startup... This would then make a comment superfluous. What do you
> think?

I agree with the approach of assigning the phandle anyway.

> 
> 
> > 
> >> +			>;
> >> +		};
> >> +
> >> +		pinctrl_usbdev0_ext: gpio_usb_cdet {
> >> +			fsl,pins = <
> >> +				VF610_PAD_PTC29__GPIO_102		0x22ed
> > 
> > How is this one used?
> 
> This is not yet used. It is more or less the OTG-ID pin, but on 3.3V
> level. We use that on the Colibri standard to switch between Host/Device
> mode, however a driver which uses that GPIO is still outstanding. I can
> also leave that away for now, if you prefer....

Then let's add it when it's actually required.

Shawn

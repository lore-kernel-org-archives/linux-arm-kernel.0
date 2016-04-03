From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 3 Apr 2016 11:56:33 +0900
Subject: [PATCH 06/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos5250
In-Reply-To: <56FEAE29.6010405@osg.samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-6-git-send-email-k.kozlowski@samsung.com>
 <56FEAE29.6010405@osg.samsung.com>
Message-ID: <20160403025633.GA3789@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 01:21:45PM -0400, Javier Martinez Canillas wrote:
> >  
> > -	usb at 12000000 {
> > +	usb_dwc3 {
> >  		compatible = "samsung,exynos5250-dwusb3";
> >  		clocks = <&clock CLK_USB3>;
> >  		clock-names = "usbdrd30";
> 
> The ePAPR document says that "The name of a node should be somewhat generic,
> reflecting the function of the device and not its precise programming model"
> 
> So I wonder if this shouldn't be instead:
> 
> usb_dwc3: usb {

There are already nodes with 'usb' name:
	ehci: usb at 12110000 {
		compatible = "samsung,exynos4210-ehci";
		...
	}
	ohci: usb at 12120000 {
		compatible = "samsung,exynos4210-ohci";
	}
Having nodes with the same name but some with address some not, should
work (none should be overridden)... but looks a little bit weird.

Anyway I am fine with both.


> Although it seems that not all DT bindings follow this convention so probably
> the name in your patch is correct.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks for review and comments. I already spotted the 'memory' node
issue so I won't be replying to you with acknowledging comments. :)

BR,
Krzysztof

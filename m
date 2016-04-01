From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:21:45 -0400
Subject: [PATCH 06/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos5250
In-Reply-To: <1459493874-2366-6-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEAE29.6010405@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Patch looks good to me, I have just one question below:

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in all Exynos5250 boards:
> 
> Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/display-timings/timing at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /usb at 12000000 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /usb at 12000000/dwc3 has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /hdmi has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /mixer has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /video-phy at 10040720 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /fixed-regulator at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /fixed-regulator at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /fixed-regulator at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 12C70000/trackpad has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 20/ports/port at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 20/ports/port at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c-arbitrator/i2c at 0/embedded-controller has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /i2c-arbitrator/i2c at 0/power-regulator has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /i2c at 12CA0000/embedded-controller has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
> -	usb at 12000000 {
> +	usb_dwc3 {
>  		compatible = "samsung,exynos5250-dwusb3";
>  		clocks = <&clock CLK_USB3>;
>  		clock-names = "usbdrd30";

The ePAPR document says that "The name of a node should be somewhat generic,
reflecting the function of the device and not its precise programming model"

So I wonder if this shouldn't be instead:

usb_dwc3: usb {

Although it seems that not all DT bindings follow this convention so probably
the name in your patch is correct.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

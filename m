From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 26 Apr 2015 12:16:05 +0200
Subject: [PATCH v1 2/2] ARM: dts: rockchip: set dr_mode property for
 rk3288-firefly board
In-Reply-To: <1430041299-24874-2-git-send-email-lyz@rock-chips.com>
References: <1430041299-24874-1-git-send-email-lyz@rock-chips.com>
 <1430041299-24874-2-git-send-email-lyz@rock-chips.com>
Message-ID: <8829961.lJFBlrS3Ia@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Sonntag, 26. April 2015, 17:41:39 schrieb Yunzhi Li:
> rk3288-firefly board use the dwc2 usb otg controller as a host
> controller and the device mode not used, so the dr_mode should be
> "host" then the dwc2 usb otg controller will work at host only
> mode
> 
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

Not sure I understand. Is this some sort of hardware limitation? Because when 
for example flashing a kernel via upgrade_tool it is working just fine as 
gadget.

If it is a software choice, this should not be made in the devicetree, as the 
dt describes the hardware alone.


Heiko


> 
> ---
> 
>  arch/arm/boot/dts/rk3288-firefly.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi
> b/arch/arm/boot/dts/rk3288-firefly.dtsi index e6f873a..a861776 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -466,6 +466,7 @@
>  };
> 
>  &usb_otg {
> +	dr_modr = "host";
>  	status = "okay";
>  };

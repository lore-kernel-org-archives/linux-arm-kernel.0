From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 20 Nov 2015 14:39:33 +0900
Subject: [PATCH 2/2] arm: boot: beaglex15: pass correct interrupt
In-Reply-To: <1447350781-20649-3-git-send-email-balbi@ti.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447350781-20649-3-git-send-email-balbi@ti.com>
Message-ID: <564EB215.5080209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2015? 11? 13? 02:53, Felipe Balbi wrote:
> According to latest schematics [1], GPIO_1/VBUSDET
> on TPS659038 is tied to AM57x GPIO4_21. We can use
> that as a VBUS interrupt, instead of relying on
> PMIC's VBUS interrupts which don't seem to be firing
> on x15 at all.
> 
> A follow up patch will add support for using this
> GPIO-based interrupt mechanism for notifying about
> VBUS.
> 
> [1] https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 6f3a1a7ec5f9..5e47162f7883 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -560,6 +560,7 @@
>  		extcon_usb2: tps659038_usb {
>  			compatible = "ti,palmas-usb-vid";
>  			ti,enable-vbus-detection;
> +			interrupts-extended = <&gpio4 21 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
>  	};
> 

I check the schematic file. The GPIO4_21 pin is connected as following:
- GPIO_1/VBUSDET -> PMIC_VBUS_DET -> VBUS_DET -> AM5728 GPIO4_21 pin

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

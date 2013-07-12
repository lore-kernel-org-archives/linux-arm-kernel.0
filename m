From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Jul 2013 15:45:54 +0300
Subject: [PATCH] arm: omap5: dts: fix reg property size
In-Reply-To: <1373630285-17389-1-git-send-email-balbi@ti.com>
References: <1373630285-17389-1-git-send-email-balbi@ti.com>
Message-ID: <20130712124554.GA18154@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Benoit

On Fri, Jul 12, 2013 at 02:58:05PM +0300, Felipe Balbi wrote:
> USB3 block has a 64KiB space, another 64KiB is
> used for the wrapper.
> 
> Without this change, resource_size() will get
> confused and driver won't probe because size
> will be negative.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> does anybody know Benoit's knew email address ?
> 
>  arch/arm/boot/dts/omap5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index e643620..5c99f19 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -637,7 +637,7 @@
>  		omap_dwc3 at 4a020000 {
>  			compatible = "ti,dwc3";
>  			ti,hwmods = "usb_otg_ss";
> -			reg = <0x4a020000 0x1000>;
> +			reg = <0x4a020000 0x10000>;
>  			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -645,7 +645,7 @@
>  			ranges;
>  			dwc3 at 4a030000 {
>  				compatible = "synopsys,dwc3";
> -				reg = <0x4a030000 0x1000>;
> +				reg = <0x4a030000 0x10000>;
>  				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>  				usb-phy = <&usb2_phy>, <&usb3_phy>;
>  				tx-fifo-resize;
> -- 
> 1.8.2.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/5a82452d/attachment.sig>

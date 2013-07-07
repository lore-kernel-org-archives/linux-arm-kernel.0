From: balbi@ti.com (Felipe Balbi)
Date: Sun, 7 Jul 2013 11:35:58 +0300
Subject: [PATCH] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <1372401887-19422-1-git-send-email-george.cherian@ti.com>
References: <1372401887-19422-1-git-send-email-george.cherian@ti.com>
Message-ID: <20130707083558.GA12992@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 28, 2013 at 12:14:47PM +0530, George Cherian wrote:
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index ddc1df7..e4f5eb8 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -64,5 +64,24 @@
>  			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
>  			reg = <0x44e86000 0x40>;
>  		};
> +
> +		usb_otg_hs1: am4372_dwc3 at 48380000 {
> +			compatible = "ti,am437x-dwc3";
> +			reg = <0x48380000 0x1ff>;
> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			utmi-mode = <1>;
> +			ranges;
> +
> +			dwc3 at 48390000 {
> +				compatible = "synopsys,dwc3";

let's us snps,dwc3. I recently posted a patch converting synopsys to
snps like all other DesignWare drivers. Support for synopsys,dwc3 is
still there, but shouldn't be used.

> +				reg = <0x48390000 0xcfff>;
> +				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
> +				tx-fifo-resize;

is this flag *really* necessary, I asked you and didn't get an answer.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130707/cc0b9525/attachment-0001.sig>

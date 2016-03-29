From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Mar 2016 10:41:59 +0100
Subject: [PATCH] ARM: bcm2835: add CPU node for ARM core
In-Reply-To: <1459182081-30819-1-git-send-email-stefan.wahren@i2se.com>
References: <1459182081-30819-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20160329094158.GB26574@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 04:21:20PM +0000, Stefan Wahren wrote:
> This patch adds the CPU node of the BCM2835 into the DT.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/bcm2835.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index b83b326..e87aba1 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -3,6 +3,17 @@
>  / {
>  	compatible = "brcm,bcm2835";
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,arm1176jzf-s", "arm,arm1176";
> +			reg = <0x0>;
> +		};
> +	};

Minor nit: the "arm,arm1176" fallback isn't documented, nor used
elsewhere, so it can/should be dropped.

Otherwise, this looks fine per [1]. With the above change, feel free to
add my ack.

Mark.

[1] Documentation/devicetree/bindings/arm/cpus.txt

> +
>  	soc {
>  		ranges = <0x7e000000 0x20000000 0x02000000>;
>  		dma-ranges = <0x40000000 0x00000000 0x20000000>;
> -- 
> 1.7.9.5
> 

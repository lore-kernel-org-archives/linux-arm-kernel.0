From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:04:44 +0100
Subject: [PATCH v2 13/19] ARM: dts: Add OpenBMC flash layout
In-Reply-To: <20171215062443.23059-14-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-14-joel@jms.id.au>
Message-ID: <1becbfbe-cc2b-78d6-dd3b-00cdefa9b799@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> This is a layout used by OpenBMC systems. It describes the fixed flash
> layout of a 32MB mtd device.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>


> ---
>  arch/arm/boot/dts/openbmc-flash-layout.dtsi | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi
> 
> diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
> new file mode 100644
> index 000000000000..63ad8db7a431
> --- /dev/null
> +++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +partitions {
> +	compatible = "fixed-partitions";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	u-boot at 0 {
> +		reg = <0x0 0x60000>;
> +		label = "u-boot";
> +	};
> +
> +	u-boot-env at 60000 {
> +		reg = <0x60000 0x20000>;
> +		label = "u-boot-env";
> +	};
> +
> +	kernel at 80000 {
> +		reg = <0x80000 0x440000>;
> +		label = "kernel";
> +	};
> +
> +	rofs at 0c0000 {
> +		reg = <0x4c0000 0x1740000>;
> +		label = "rofs";
> +	};
> +
> +	rwfs at 1c00000 {
> +		reg = <0x1c00000 0x400000>;
> +		label = "rwfs";
> +	};
> +};
> 

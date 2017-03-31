From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 31 Mar 2017 09:49:47 +0800
Subject: [PATCH 1/3] dts: arm64: add DPAA QBMan portals
In-Reply-To: <1490884672-18294-2-git-send-email-madalin.bucur@nxp.com>
References: <1490884672-18294-1-git-send-email-madalin.bucur@nxp.com>
 <1490884672-18294-2-git-send-email-madalin.bucur@nxp.com>
Message-ID: <20170331014945.GH683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 05:37:50PM +0300, Madalin Bucur wrote:
> Add the DPAA 1.x DPAA QMan and BMan portal nodes.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

The patches should be prefixed like 'arm64: dts: ...'.

> ---
>  .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67 +++++++++++++++++++
>  .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76 ++++++++++++++++++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi

What does the suffix number '1' mean here?

> 
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> new file mode 100644
> index 0000000..b007344
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> @@ -0,0 +1,67 @@
> +/*
> + * QorIQ BMan Portals device tree
> + *
> + * Copyright 2011-2016 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +&bportals {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";
> +
> +	bman-portal at 0 {
> +		compatible = "fsl,bman-portal";

The bindings/soc/fsl/bman-portals.txt says: Must include
"fsl,bman-portal-<hardware revision>".

> +		reg = <0x0 0x4000 0x4000000 0x4000>;

Can we write it in the same way how the example in the bindings doc
does? 

	reg = <0x0 0x4000>, <0x4000000 0x4000>;

It's more obvious to tell that it has two memory regions.

> +		interrupts = <0 173 0x4>;

Can we use GIC_SPI and IRQ_TYPE_LEVEL_HIGH which are defined by
headers in include/dt-bindings/interrupt-controller/ to make it more
readable?

Shawn

> +	};
> +
> +	bman-portal at 10000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x10000 0x4000 0x4010000 0x4000>;
> +		interrupts = <0 175 0x4>;
> +	};
> +
> +	bman-portal at 20000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x20000 0x4000 0x4020000 0x4000>;
> +		interrupts = <0 177 0x4>;
> +	};
> +
> +	bman-portal at 30000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x30000 0x4000 0x4030000 0x4000>;
> +		interrupts = <0 179 0x4>;
> +	};
> +
> +	bman-portal at 40000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x40000 0x4000 0x4040000 0x4000>;
> +		interrupts = <0 181 0x4>;
> +	};
> +
> +	bman-portal at 50000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x50000 0x4000 0x4050000 0x4000>;
> +		interrupts = <0 183 0x4>;
> +	};
> +
> +	bman-portal at 60000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x60000 0x4000 0x4060000 0x4000>;
> +		interrupts = <0 185 0x4>;
> +	};
> +
> +	bman-portal at 70000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x70000 0x4000 0x4070000 0x4000>;
> +		interrupts = <0 187 0x4>;
> +	};
> +
> +	bman-portal at 80000 {
> +		compatible = "fsl,bman-portal";
> +		reg = <0x80000 0x4000 0x4080000 0x4000>;
> +		interrupts = <0 189 0x4>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi
> new file mode 100644
> index 0000000..4baec2c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/qoriq-qman1-portals.dtsi
> @@ -0,0 +1,76 @@
> +/*
> + * QorIQ QMan Portals device tree
> + *
> + * Copyright 2011-2016 Freescale Semiconductor Inc.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> + */
> +
> +&qportals {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";
> +
> +	qportal0: qman-portal at 0 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x0 0x4000 0x4000000 0x4000>;
> +		interrupts = <0 172 0x4>;
> +		cell-index = <0>;
> +	};
> +
> +	qportal1: qman-portal at 10000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x10000 0x4000 0x4010000 0x4000>;
> +		interrupts = <0 174 0x4>;
> +		cell-index = <1>;
> +	};
> +
> +	qportal2: qman-portal at 20000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x20000 0x4000 0x4020000 0x4000>;
> +		interrupts = <0 176 0x4>;
> +		cell-index = <2>;
> +	};
> +
> +	qportal3: qman-portal at 30000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x30000 0x4000 0x4030000 0x4000>;
> +		interrupts = <0 178 0x4>;
> +		cell-index = <3>;
> +	};
> +
> +	qportal4: qman-portal at 40000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x40000 0x4000 0x4040000 0x4000>;
> +		interrupts = <0 180 0x4>;
> +		cell-index = <4>;
> +	};
> +
> +	qportal5: qman-portal at 50000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x50000 0x4000 0x4050000 0x4000>;
> +		interrupts = <0 182 0x4>;
> +		cell-index = <5>;
> +	};
> +
> +	qportal6: qman-portal at 60000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x60000 0x4000 0x4060000 0x4000>;
> +		interrupts = <0 184 0x4>;
> +		cell-index = <6>;
> +	};
> +
> +	qportal7: qman-portal at 70000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x70000 0x4000 0x4070000 0x4000>;
> +		interrupts = <0 186 0x4>;
> +		cell-index = <7>;
> +	};
> +
> +	qportal8: qman-portal at 80000 {
> +		compatible = "fsl,qman-portal";
> +		reg = <0x80000 0x4000 0x4080000 0x4000>;
> +		interrupts = <0 188 0x4>;
> +		cell-index = <8>;
> +	};
> +};
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

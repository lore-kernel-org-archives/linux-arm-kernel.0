From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Feb 2016 17:33:33 +0000
Subject: [PATCH 1/2 v3] dt/bindings: Add bindings for Layerscape SCFG MSI
In-Reply-To: <1454403648-5551-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1454403648-5551-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <56C4AEED.4060901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 09:00, Minghuan Lian wrote:
> Some Layerscape SoCs use a simple MSI controller implementation.
> It contains only two SCFG register to trigger and describe a
> group 32 MSI interrupts. The patch adds bindings to describe
> the controller.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> new file mode 100644
> index 0000000..0c41151
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> @@ -0,0 +1,23 @@
> +* Freescale Layerscape SCFG PCIe MSI controller
> +
> +Required properties:
> +
> +- compatible: should be "fsl,<soc-name>-msi" to identify
> +	      Layerscape PCIe MSI controller block such as:
> +              "fsl,1s1021a-msi"
> +              "fsl,1s1043a-msi"
> +- msi-controller: indicates that this is a PCIe MSI controller node
> +- reg: physical base address of the controller and length of memory mapped.
> +- interrupts: A interrupt of the controller.

This is an interrupt *to* the the parent interrupt controller.

> +
> +Each PCIe node needs to have property msi-parent that points to
> +MSI controller node
> +
> +Examples:
> +
> +	msi1: msi-controller at 1571000 {
> +		compatible = "fsl,1s1043a-msi";
> +		reg = <0x0 0x1571000 0x0 0x8>,
> +		msi-controller;
> +		interrupts = <0 116 0x4>;
> +	};
> 

Please document the need for an interrupt-parent property. Your example
assumes that there is a default one...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

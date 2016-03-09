From: minghuan.lian@nxp.com (Minghuan Lian)
Date: Wed, 9 Mar 2016 08:57:34 +0000
Subject: [PATCH 1/2 v5] dt/bindings: Add bindings for Layerscape SCFG MSI
In-Reply-To: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <VI1PR04MB161551B58DBC718C91D4DA28E8B30@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob Herring,

Could you help to review this patch?
Thanks a lot.

Regards,
Minghuan


> -----Original Message-----
> From: Minghuan Lian [mailto:Minghuan.Lian at nxp.com]
> Sent: Monday, March 07, 2016 11:36 AM
> To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Marc Zyngier <marc.zyngier@arm.com>; Thomas Gleixner
> <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>; Roy Zang
> <roy.zang@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Stuart Yoder
> <stuart.yoder@nxp.com>; Yang-Leo Li <leoyang.li@nxp.com>; Minghuan Lian
> <minghuan.lian@nxp.com>
> Subject: [PATCH 1/2 v5] dt/bindings: Add bindings for Layerscape SCFG MSI
> 
> Some Layerscape SoCs use a simple MSI controller implementation.
> It contains only two SCFG register to trigger and describe a
> group 32 MSI interrupts. The patch adds bindings to describe
> the controller.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> change log:
> v4: add interrupt-parent description
> v3-v1: no change
> 
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       | 30
> ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> new file mode 100644
> index 0000000..9e38949
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> @@ -0,0 +1,30 @@
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
> +- interrupts: an interrupt to the parent interrupt controller.
> +
> +Optional properties:
> +- interrupt-parent: the phandle to the parent interrupt controller.
> +
> +This interrupt controller hardware is a second level interrupt controller that
> +is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
> +platforms. If interrupt-parent is not provided, the default parent interrupt
> +controller will be used.
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
> --
> 1.9.1

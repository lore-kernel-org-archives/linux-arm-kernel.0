From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 11:44:47 -0600
Subject: [PATCH 7/9] irqchip/ls-scfg-msi: add LS1046a MSI support
In-Reply-To: <1482829985-24421-7-git-send-email-Minghuan.Lian@nxp.com>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
 <1482829985-24421-7-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20170103174447.cy4b7nafea7s4hwf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:13:03PM +0800, Minghuan Lian wrote:
> LS1046a includes 4 MSIRs, each MSIR is assigned a dedicate GIC
> SPI interrupt and provides 32 MSI interrupts. Compared to previous
> MSI, LS1046a's IBS(interrupt bit select) shift is changed to 2 and
> total MSI interrupt number is changed to 128.
> 
> The patch adds structure 'ls_scfg_msir' to describe MSIR setting and
> 'ibs_shift' to store the different value between the SoCs.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |   2 +-
>  drivers/irqchip/irq-ls-scfg-msi.c                  | 161 ++++++++++++++++-----
>  2 files changed, 127 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> index 54597b0..dde4552 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> @@ -6,7 +6,7 @@ Required properties:
>  	      Layerscape PCIe MSI controller block such as:
>                "fsl,ls1021a-msi"
>                "fsl,ls1043a-msi"
> -	      "fsl,ls1046a-msi"
> +              "fsl,ls1046a-msi"

This hunk goes in the previous patch...

>  - msi-controller: indicates that this is a PCIe MSI controller node
>  - reg: physical base address of the controller and length of memory mapped.
>  - interrupts: an interrupt to the parent interrupt controller.

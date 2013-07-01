From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 1 Jul 2013 15:38:19 +0530
Subject: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
In-Reply-To: <1372662947-27160-4-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
Message-ID: <51D15513.7020101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/1/2013 12:45 PM, Sean Cross wrote:
> This adds a PCI Express port driver for the on-chip PCI Express port
> present on the i.MX6 SoC.  It is based on the PCI Express driver available
> in the Freescale BSP.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---

...

> diff --git a/drivers/pci/pcie/pcie-imx.c b/drivers/pci/pcie/pcie-imx.c
> new file mode 100644
> index 0000000..664679e
> --- /dev/null
> +++ b/drivers/pci/pcie/pcie-imx.c

Should go to drivers/pci/host/

> @@ -0,0 +1,1049 @@
> +/*
> + * drivers/pci/pcie/pcie-imx.c
> + *

...


> +#define ATU_R_BaseAddress 0x900
> +#define PCIE_PL_iATUVR (ATU_R_BaseAddress + 0x0)
> +#define PCIE_PL_iATURC1 (ATU_R_BaseAddress + 0x4)
> +#define PCIE_PL_iATURC2 (ATU_R_BaseAddress + 0x8)
> +#define PCIE_PL_iATURLBA (ATU_R_BaseAddress + 0xC)
> +#define PCIE_PL_iATURUBA (ATU_R_BaseAddress + 0x10)
> +#define PCIE_PL_iATURLA (ATU_R_BaseAddress + 0x14)
> +#define PCIE_PL_iATURLTA (ATU_R_BaseAddress + 0x18)
> +#define PCIE_PL_iATURUTA (ATU_R_BaseAddress + 0x1C)

I may be wrong, but from these offset it seems to me that it is SNPS 
controller. If yes, then please go through comments of
"[PATCH V1-10 0/4] PCIe support for Samsung Exynos5440 SoC"

Regards
Pratyush

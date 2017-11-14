From: ley.foon.tan@intel.com (Ley Foon Tan)
Date: Wed, 15 Nov 2017 00:58:40 +0800
Subject: [PATCH v1 2/3] PCI: altera: Rename altera_pcie_link_is_up() to
 altera_pcie_link_up()
In-Reply-To: <20171113224051.29024.76516.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171113224051.29024.76516.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1510678720.2460.2.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-11-13 at 16:40 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename altera_pcie_link_is_up() to altera_pcie_link_up() to follow
> the
> convention of other drivers.??No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> ?drivers/pci/host/pcie-altera.c |????8 ++++----
> ?1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c
> index b468b8cccf8d..5cc4f594d79a 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -105,7 +105,7 @@ static inline u32 cra_readl(struct altera_pcie
> *pcie, const u32 reg)
> ????????return readl_relaxed(pcie->cra_base + reg);
> ?}
> 
> -static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
> +static bool altera_pcie_link_up(struct altera_pcie *pcie)
> ?{
> ????????return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) ==
> LTSSM_L0);
> ?}
> @@ -142,7 +142,7 @@ static bool altera_pcie_valid_device(struct
> altera_pcie *pcie,
> ?{
> ????????/* If there is no link, then there is no device */
> ????????if (bus->number != pcie->root_bus_nr) {
> -???????????????if (!altera_pcie_link_is_up(pcie))
> +???????????????if (!altera_pcie_link_up(pcie))
> ????????????????????????return false;
> ????????}
> 
> @@ -412,7 +412,7 @@ static void altera_wait_link_retrain(struct
> altera_pcie *pcie)
> ????????/* Wait for link is up */
> ????????start_jiffies = jiffies;
> ????????for (;;) {
> -???????????????if (altera_pcie_link_is_up(pcie))
> +???????????????if (altera_pcie_link_up(pcie))
> ????????????????????????break;
> 
> ????????????????if (time_after(jiffies, start_jiffies +
> LINK_UP_TIMEOUT)) {
> @@ -427,7 +427,7 @@ static void altera_pcie_retrain(struct
> altera_pcie *pcie)
> ?{
> ????????u16 linkcap, linkstat, linkctl;
> 
> -???????if (!altera_pcie_link_is_up(pcie))
> +???????if (!altera_pcie_link_up(pcie))
> ????????????????return;
> 
> ????????/*
> 
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

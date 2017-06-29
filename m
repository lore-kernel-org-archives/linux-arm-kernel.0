From: rric@kernel.org (Robert Richter)
Date: Thu, 29 Jun 2017 12:14:52 +0200
Subject: [PATCH] EDAC: Get rid of mci->mod_ver
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Message-ID: <20170629101452.GC10237@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.06.17 12:03:11, Borislav Petkov wrote:
> Hi,
> 
> any objections?
> 
> ---
> It is a write-only variable so get rid of it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Mark Gross <mark.gross@intel.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Ranganathan Desikan <ravi@jetztechnologies.com>
> Cc: "Arvind R." <arvino55@gmail.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Loc Ho <lho@apm.com>
> Cc: linux-edac at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mips at linux-mips.org
> ---
>  drivers/edac/altera_edac.c      | 2 --
>  drivers/edac/amd64_edac.c       | 1 -
>  drivers/edac/amd76x_edac.c      | 2 --
>  drivers/edac/cpc925_edac.c      | 1 -
>  drivers/edac/e752x_edac.c       | 2 --
>  drivers/edac/e7xxx_edac.c       | 2 --
>  drivers/edac/ghes_edac.c        | 3 ---
>  drivers/edac/highbank_mc_edac.c | 1 -
>  drivers/edac/i3000_edac.c       | 3 ---
>  drivers/edac/i3200_edac.c       | 3 ---
>  drivers/edac/i5000_edac.c       | 1 -
>  drivers/edac/i5100_edac.c       | 1 -
>  drivers/edac/i5400_edac.c       | 1 -
>  drivers/edac/i7300_edac.c       | 1 -
>  drivers/edac/i7core_edac.c      | 1 -
>  drivers/edac/i82443bxgx_edac.c  | 3 ---
>  drivers/edac/i82860_edac.c      | 2 --
>  drivers/edac/i82875p_edac.c     | 2 --
>  drivers/edac/i82975x_edac.c     | 2 --
>  drivers/edac/ie31200_edac.c     | 2 --
>  drivers/edac/mv64x60_edac.c     | 1 -
>  drivers/edac/ppc4xx_edac.c      | 1 -
>  drivers/edac/r82600_edac.c      | 2 --
>  drivers/edac/sb_edac.c          | 1 -
>  drivers/edac/skx_edac.c         | 3 ---
>  drivers/edac/synopsys_edac.c    | 1 -
>  drivers/edac/thunderx_edac.c    | 1 -
>  drivers/edac/x38_edac.c         | 3 ---
>  drivers/edac/xgene_edac.c       | 1 -
>  include/linux/edac.h            | 1 -
>  30 files changed, 51 deletions(-)

Looks sane to me. For Highbank and ThunderX:

Acked-by: Robert Richter <rric@kernel.org>

> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index db75d4b614f7..fa2e5db56d24 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -38,7 +38,6 @@
>  #include "edac_module.h"
>  
>  #define EDAC_MOD_STR		"altera_edac"
> -#define EDAC_VERSION		"1"
>  #define EDAC_DEVICE		"Altera"
>  
>  static const struct altr_sdram_prv_data c5_data = {
> @@ -392,7 +391,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = EDAC_VERSION;
>  	mci->ctl_name = dev_name(&pdev->dev);
>  	mci->scrub_mode = SCRUB_SW_SRC;
>  	mci->dev_name = dev_name(&pdev->dev);
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 3aea55698165..ac2f30295efe 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3130,7 +3130,6 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci,
>  
>  	mci->edac_cap		= determine_edac_cap(pvt);
>  	mci->mod_name		= EDAC_MOD_STR;
> -	mci->mod_ver		= EDAC_AMD64_VERSION;
>  	mci->ctl_name		= fam->ctl_name;
>  	mci->dev_name		= pci_name(pvt->F3);
>  	mci->ctl_page_to_phys	= NULL;
> diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
> index a7450275ad28..9c6e326b4c14 100644
> --- a/drivers/edac/amd76x_edac.c
> +++ b/drivers/edac/amd76x_edac.c
> @@ -19,7 +19,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define AMD76X_REVISION	" Ver: 2.0.2"
>  #define EDAC_MOD_STR	"amd76x_edac"
>  
>  #define amd76x_printk(level, fmt, arg...) \
> @@ -263,7 +262,6 @@ static int amd76x_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_cap = ems_mode ?
>  		(EDAC_FLAG_EC | EDAC_FLAG_SECDED) : EDAC_FLAG_NONE;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = AMD76X_REVISION;
>  	mci->ctl_name = amd76x_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = amd76x_check;
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index 837b62c4993d..cba8ee14a067 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -999,7 +999,6 @@ static int cpc925_probe(struct platform_device *pdev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = CPC925_EDAC_MOD_STR;
> -	mci->mod_ver = CPC925_EDAC_REVISION;
>  	mci->ctl_name = pdev->name;
>  
>  	if (edac_op_state == EDAC_OPSTATE_POLL)
> diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
> index 1a352cae1f52..b5de9a13ea3f 100644
> --- a/drivers/edac/e752x_edac.c
> +++ b/drivers/edac/e752x_edac.c
> @@ -26,7 +26,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define E752X_REVISION	" Ver: 2.0.2"
>  #define EDAC_MOD_STR	"e752x_edac"
>  
>  static int report_non_memory_errors;
> @@ -1303,7 +1302,6 @@ static int e752x_probe1(struct pci_dev *pdev, int dev_idx)
>  		(EDAC_FLAG_NONE | EDAC_FLAG_SECDED | EDAC_FLAG_S4ECD4ED);
>  	/* FIXME - what if different memory types are in different csrows? */
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = E752X_REVISION;
>  	mci->pdev = &pdev->dev;
>  
>  	edac_dbg(3, "init pvt\n");
> diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
> index 67ef07aed923..75d7ce62b3be 100644
> --- a/drivers/edac/e7xxx_edac.c
> +++ b/drivers/edac/e7xxx_edac.c
> @@ -32,7 +32,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define	E7XXX_REVISION " Ver: 2.0.2"
>  #define	EDAC_MOD_STR	"e7xxx_edac"
>  
>  #define e7xxx_printk(level, fmt, arg...) \
> @@ -458,7 +457,6 @@ static int e7xxx_probe1(struct pci_dev *pdev, int dev_idx)
>  		EDAC_FLAG_S4ECD4ED;
>  	/* FIXME - what if different memory types are in different csrows? */
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = E7XXX_REVISION;
>  	mci->pdev = &pdev->dev;
>  	edac_dbg(3, "init pvt\n");
>  	pvt = (struct e7xxx_pvt *)mci->pvt_info;
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 4e61a6229dd2..6f80eb65c26c 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -17,8 +17,6 @@
>  #include "edac_module.h"
>  #include <ras/ras_event.h>
>  
> -#define GHES_EDAC_REVISION " Ver: 1.0.0"
> -
>  struct ghes_edac_pvt {
>  	struct list_head list;
>  	struct ghes *ghes;
> @@ -451,7 +449,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "ghes_edac.c";
> -	mci->mod_ver = GHES_EDAC_REVISION;
>  	mci->ctl_name = "ghes_edac";
>  	mci->dev_name = "ghes";
>  
> diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
> index 0e7e0a404d89..6092e61be605 100644
> --- a/drivers/edac/highbank_mc_edac.c
> +++ b/drivers/edac/highbank_mc_edac.c
> @@ -224,7 +224,6 @@ static int highbank_mc_probe(struct platform_device *pdev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = pdev->dev.driver->name;
> -	mci->mod_ver = "1";
>  	mci->ctl_name = id->compatible;
>  	mci->dev_name = dev_name(&pdev->dev);
>  	mci->scrub_mode = SCRUB_SW_SRC;
> diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
> index 5306240570d7..8085a32ec3bd 100644
> --- a/drivers/edac/i3000_edac.c
> +++ b/drivers/edac/i3000_edac.c
> @@ -16,8 +16,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define I3000_REVISION		"1.1"
> -
>  #define EDAC_MOD_STR		"i3000_edac"
>  
>  #define I3000_RANKS		8
> @@ -375,7 +373,6 @@ static int i3000_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I3000_REVISION;
>  	mci->ctl_name = i3000_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i3000_check;
> diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
> index 77c58d201a30..d92d56cee101 100644
> --- a/drivers/edac/i3200_edac.c
> +++ b/drivers/edac/i3200_edac.c
> @@ -17,8 +17,6 @@
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> -#define I3200_REVISION        "1.1"
> -
>  #define EDAC_MOD_STR        "i3200_edac"
>  
>  #define PCI_DEVICE_ID_INTEL_3200_HB    0x29f0
> @@ -375,7 +373,6 @@ static int i3200_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I3200_REVISION;
>  	mci->ctl_name = i3200_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i3200_check;
> diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
> index 8f5a56e25bd2..53f24b18cd61 100644
> --- a/drivers/edac/i5000_edac.c
> +++ b/drivers/edac/i5000_edac.c
> @@ -1430,7 +1430,6 @@ static int i5000_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "i5000_edac.c";
> -	mci->mod_ver = I5000_REVISION;
>  	mci->ctl_name = i5000_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index a8334c4acea7..b506eef6b146 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -1108,7 +1108,6 @@ static int i5100_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = "i5100_edac.c";
> -	mci->mod_ver = "not versioned";
>  	mci->ctl_name = "i5100";
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
> diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
> index cd889edc8516..6f8bcdb9256a 100644
> --- a/drivers/edac/i5400_edac.c
> +++ b/drivers/edac/i5400_edac.c
> @@ -1315,7 +1315,6 @@ static int i5400_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "i5400_edac.c";
> -	mci->mod_ver = I5400_REVISION;
>  	mci->ctl_name = i5400_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
> diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
> index e391f5a716be..6b5a554ba8e4 100644
> --- a/drivers/edac/i7300_edac.c
> +++ b/drivers/edac/i7300_edac.c
> @@ -1077,7 +1077,6 @@ static int i7300_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "i7300_edac.c";
> -	mci->mod_ver = I7300_REVISION;
>  	mci->ctl_name = i7300_devs[0].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 75ad847593b7..98998ef58647 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -2159,7 +2159,6 @@ static int i7core_register_mci(struct i7core_dev *i7core_dev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "i7core_edac.c";
> -	mci->mod_ver = I7CORE_REVISION;
>  	mci->ctl_name = kasprintf(GFP_KERNEL, "i7 core #%d",
>  				  i7core_dev->socket);
>  	mci->dev_name = pci_name(i7core_dev->pdev[0]);
> diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
> index cb61a5b7d080..a2ca929e2168 100644
> --- a/drivers/edac/i82443bxgx_edac.c
> +++ b/drivers/edac/i82443bxgx_edac.c
> @@ -31,8 +31,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define I82443_REVISION	"0.1"
> -
>  #define EDAC_MOD_STR    "i82443bxgx_edac"
>  
>  /* The 82443BX supports SDRAM, or EDO (EDO for mobile only), "Memory
> @@ -320,7 +318,6 @@ static int i82443bxgx_edacmc_probe1(struct pci_dev *pdev, int dev_idx)
>  				I82443BXGX_EAP_OFFSET_MBE));
>  
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I82443_REVISION;
>  	mci->ctl_name = "I82443BXGX";
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i82443bxgx_edacmc_check;
> diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
> index 236c813227fc..3e3a80ffb322 100644
> --- a/drivers/edac/i82860_edac.c
> +++ b/drivers/edac/i82860_edac.c
> @@ -16,7 +16,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define  I82860_REVISION " Ver: 2.0.2"
>  #define EDAC_MOD_STR	"i82860_edac"
>  
>  #define i82860_printk(level, fmt, arg...) \
> @@ -216,7 +215,6 @@ static int i82860_probe1(struct pci_dev *pdev, int dev_idx)
>  	/* I"m not sure about this but I think that all RDRAM is SECDED */
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I82860_REVISION;
>  	mci->ctl_name = i82860_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i82860_check;
> diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
> index e286b7e74c7a..ceac925af38c 100644
> --- a/drivers/edac/i82875p_edac.c
> +++ b/drivers/edac/i82875p_edac.c
> @@ -20,7 +20,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define I82875P_REVISION	" Ver: 2.0.2"
>  #define EDAC_MOD_STR		"i82875p_edac"
>  
>  #define i82875p_printk(level, fmt, arg...) \
> @@ -423,7 +422,6 @@ static int i82875p_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_UNKNOWN;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I82875P_REVISION;
>  	mci->ctl_name = i82875p_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i82875p_check;
> diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
> index 9dcdab28f665..892815eaa97b 100644
> --- a/drivers/edac/i82975x_edac.c
> +++ b/drivers/edac/i82975x_edac.c
> @@ -16,7 +16,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define I82975X_REVISION	" Ver: 1.0.0"
>  #define EDAC_MOD_STR		"i82975x_edac"
>  
>  #define i82975x_printk(level, fmt, arg...) \
> @@ -564,7 +563,6 @@ static int i82975x_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = I82975X_REVISION;
>  	mci->ctl_name = i82975x_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = i82975x_check;
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 4260579e6901..aac9b9b360b8 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -45,7 +45,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include "edac_module.h"
>  
> -#define IE31200_REVISION "1.0"
>  #define EDAC_MOD_STR "ie31200_edac"
>  
>  #define ie31200_printk(level, fmt, arg...) \
> @@ -420,7 +419,6 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = IE31200_REVISION;
>  	mci->ctl_name = ie31200_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = ie31200_check;
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
> index d3650df94fe8..ec5d695bbb72 100644
> --- a/drivers/edac/mv64x60_edac.c
> +++ b/drivers/edac/mv64x60_edac.c
> @@ -766,7 +766,6 @@ static int mv64x60_mc_err_probe(struct platform_device *pdev)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = MV64x60_REVISION;
>  	mci->ctl_name = mv64x60_ctl_name;
>  
>  	if (edac_op_state == EDAC_OPSTATE_POLL)
> diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
> index e55e92590106..98d6dc7ef8e8 100644
> --- a/drivers/edac/ppc4xx_edac.c
> +++ b/drivers/edac/ppc4xx_edac.c
> @@ -1063,7 +1063,6 @@ static int ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
>  	/* Initialize strings */
>  
>  	mci->mod_name		= PPC4XX_EDAC_MODULE_NAME;
> -	mci->mod_ver		= PPC4XX_EDAC_MODULE_REVISION;
>  	mci->ctl_name		= ppc4xx_edac_match->compatible,
>  	mci->dev_name		= np->full_name;
>  
> diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
> index 978916625ced..851e53e122aa 100644
> --- a/drivers/edac/r82600_edac.c
> +++ b/drivers/edac/r82600_edac.c
> @@ -22,7 +22,6 @@
>  #include <linux/edac.h>
>  #include "edac_module.h"
>  
> -#define R82600_REVISION	" Ver: 2.0.2"
>  #define EDAC_MOD_STR	"r82600_edac"
>  
>  #define r82600_printk(level, fmt, arg...) \
> @@ -316,7 +315,6 @@ static int r82600_probe1(struct pci_dev *pdev, int dev_idx)
>  		mci->edac_cap = EDAC_FLAG_NONE;
>  
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = R82600_REVISION;
>  	mci->ctl_name = "R82600";
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = r82600_check;
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 80d860cb0746..687d0f23b9cc 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -3125,7 +3125,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "sb_edac.c";
> -	mci->mod_ver = SBRIDGE_REVISION;
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
>  
> diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
> index 64bef6c9cfb4..16dea97568a1 100644
> --- a/drivers/edac/skx_edac.c
> +++ b/drivers/edac/skx_edac.c
> @@ -31,8 +31,6 @@
>  
>  #include "edac_module.h"
>  
> -#define SKX_REVISION    " Ver: 1.0 "
> -
>  /*
>   * Debug macros
>   */
> @@ -473,7 +471,6 @@ static int skx_register_mci(struct skx_imc *imc)
>  	mci->edac_cap = EDAC_FLAG_NONE;
>  	mci->mod_name = "skx_edac.c";
>  	mci->dev_name = pci_name(imc->chan[0].cdev);
> -	mci->mod_ver = SKX_REVISION;
>  	mci->ctl_page_to_phys = NULL;
>  
>  	rc = skx_get_dimm_config(mci);
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 1c01dec78ec3..0c9c59e2b5a3 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -413,7 +413,6 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	mci->ctl_name = "synps_ddr_controller";
>  	mci->dev_name = SYNPS_EDAC_MOD_STRING;
>  	mci->mod_name = SYNPS_EDAC_MOD_VER;
> -	mci->mod_ver = "1";
>  
>  	edac_op_state = EDAC_OPSTATE_POLL;
>  	mci->edac_check = synps_edac_check;
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 2d352b40ae1c..c8e8b9fd4772 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -732,7 +732,6 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  
>  	mci->mod_name = "thunderx-lmc";
> -	mci->mod_ver = "1";
>  	mci->ctl_name = "thunderx-lmc";
>  	mci->dev_name = dev_name(&pdev->dev);
>  	mci->scrub_mode = SCRUB_NONE;
> diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
> index 03c97a4bf590..cc779f3f9e2d 100644
> --- a/drivers/edac/x38_edac.c
> +++ b/drivers/edac/x38_edac.c
> @@ -18,8 +18,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include "edac_module.h"
>  
> -#define X38_REVISION		"1.1"
> -
>  #define EDAC_MOD_STR		"x38_edac"
>  
>  #define PCI_DEVICE_ID_INTEL_X38_HB	0x29e0
> @@ -357,7 +355,6 @@ static int x38_probe1(struct pci_dev *pdev, int dev_idx)
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = X38_REVISION;
>  	mci->ctl_name = x38_devs[dev_idx].ctl_name;
>  	mci->dev_name = pci_name(pdev);
>  	mci->edac_check = x38_check;
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index 669246056812..e8b81d7ef61f 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -415,7 +415,6 @@ static int xgene_edac_mc_add(struct xgene_edac *edac, struct device_node *np)
>  	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
>  	mci->edac_cap = EDAC_FLAG_SECDED;
>  	mci->mod_name = EDAC_MOD_STR;
> -	mci->mod_ver = "0.1";
>  	mci->ctl_page_to_phys = NULL;
>  	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
>  	mci->scrub_mode = SCRUB_HW_SRC;
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 8ae0f45fafd6..cd75c173fd00 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -619,7 +619,6 @@ struct mem_ctl_info {
>  	 */
>  	struct device *pdev;
>  	const char *mod_name;
> -	const char *mod_ver;
>  	const char *ctl_name;
>  	const char *dev_name;
>  	void *pvt_info;
> -- 
> 2.13.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

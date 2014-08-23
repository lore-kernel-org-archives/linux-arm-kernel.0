From: lho@apm.com (Loc Ho)
Date: Sat, 23 Aug 2014 00:28:40 -0700
Subject: [PATCH v5 0/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1408778588-3215-1-git-send-email-lho@apm.com>
References: <1408778588-3215-1-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZTmRK8VuYjrjBYfVCk1J+j+fuc8T-e-3HreKOYbuK56wVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Any update on the ARM64 memory scrub patch since posted v3?

-Loc

On Sat, Aug 23, 2014 at 12:23 AM, Loc Ho <lho@apm.com> wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver.
>
> v5:
> * Rebase to 3.17.rc1 (next)
> * Update binding documentation for additional SoC node binding resource
> * Enable MCU correctable and uncorrectable interrupts if not enabled by
>   firmware
> * Enable top level interrupt only after all MCU registered. Otherwise,
>   error interrupt will never get cleared by the corresponding MCU.
> * Remove clearing of L1 and L2 errors during initialization time. Otherwise,
>   they will not be captured between firmware booting and error configuration.
> * Add capture and clearing SoC register bus errors
> * Add register bus resource to SoC DT node
>
> v4:
> * Fix PMD l1/l2 error reading address due to wrong variable type
> * Fix clearing of software generated and HW errors for l1/l2
>
> v3:
> * Update binding documentation for PMD DT node and exampples
> * Add binding documentation for SoC DT node
> * Change MC, PMD, and L3C driver error injection to use debugfs
> * Add missing IRQ for MC correctable error (code and DT)
> * Use true/false where appropriate instead 1/0
> * Add bit definition for L1 MMUESR register and fully decode this error
> * Remove the un-necessary dev variable from xgene_edac_pmd_ctx structure
> * Add check for disabled PMD (code and DT)
> * Switch to edac_printk instead pr_err
> * Some minor comments update
>
> v2:
> * Add EDAC entry in MAINTAINERS for APM EDAC driver
> * Remove the MC scrub patch
> * Remove the word 'Caches' from Kconfig
> * Change all MASK defines to use BIT(x)
> * Update comment or remove them
> * Wrap error injection code around CONFIG_EDAC_DEBUG
> * Change function name xgene_edac_mc_hw_init to xgene_edac_mc_irq_ctl
> * Change all function XXX_hw_init to XXX_hw_ctl
> * Fix typo 'activie'
> * Move calling function edac_mc_alloc after resource retrieval
> * Check for NULL on platform_get_resource return if reference directly
> * Add documentation for struct xgene_edac_pmd_ctx
> * Move L1 and L2 check out of function xgene_edac_pmd_check to its own
>   functions
> * Use for loop for configure each CPU of an PMD
> * Replace /2 by >> 1
> * Remove unnecessary comment on edac_device_add_device failure
> * Make mem_err_ip static const
> * Unwind EDAC register correctly if failed
> ---
> Loc Ho (4):
>   MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
>   Documentation: Add documentation for the APM X-Gene SoC EDAC DTS
>     binding
>   edac: Add APM X-Gene SoC EDAC driver
>   arm64: Add APM X-Gene SoC EDAC DTS entries
>
>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |   83 +
>  MAINTAINERS                                        |    8 +
>  arch/arm64/boot/dts/apm-storm.dtsi                 |   98 +
>  drivers/edac/Kconfig                               |    9 +-
>  drivers/edac/Makefile                              |    3 +
>  drivers/edac/xgene_edac.c                          | 2132 ++++++++++++++++++++
>  6 files changed, 2332 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>  create mode 100644 drivers/edac/xgene_edac.c
>

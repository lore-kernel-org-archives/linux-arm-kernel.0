From: tthayer@opensource.altera.com (Thor Thayer)
Date: Thu, 29 Jan 2015 14:53:06 -0600
Subject: [PATCHv6 0/5] Add Altera peripheral memories to EDAC framework
In-Reply-To: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <54CA9DB2.4070109@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Device Tree Maintainers,

On 01/08/2015 08:53 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>
> This patch adds the L2 cache and OCRAM peripherals to the EDAC framework
> using the EDAC device framework. The ECC is enabled early in the boot
> process in the platform specific code.
>

The changes in this patch series revision were mainly to address device 
tree concerns. There were changes in other areas of the code to address 
these changes but I believe the other maintainers are waiting to see if 
these changes are accepted before they will review (they had approved 
the previous patch changes).

How does the this patch series appear from a device tree perspective?

Thank you for your time,

Thor


> v2 changes:
> - Split On-Chip RAM ECC platform initialization into separate patch from
>    L2 ECC platform initialization.
> - Fix L2 cache dependency comments.
> - Remove OCRAM node from dts and reference prior patch.
>
> v3 changes:
> - Move L2 cache & On-Chip RAM EDAC code into altera_edac.c
> - Remove SDRAM module compile.
>
> v4 changes:
> - Change mask defines to use BIT().
> - Fix comment style to agree with kernel coding style.
> - Better printk description for read != write in trigger.
> - Remove SysFS debugging message.
> - Better dci->mod_name
> - Move gen_pool pointer assignment to end of function.
> - Invert logic to reduce indent in ocram depenency check.
> - Change from dev_err() to edac_printk()
> - Replace magic numbers with defines & comments.
> - Improve error injection test.
> - Change Makefile intermediary name to altr (from alt)
>
> v5 changes:
> - Remove l2cache.h by using if (IS_ENABLED(CONFIG_EDAC_ALTERA_L2C))
> - Remove ocram.h by using if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
> - Check prop variable before using. Include io.h.
> - Add defines for better readability. Remove MAINTAINERS changes.
>
> v6 changes:
> - Simplify OCRAM initialization. Remove be32_to_cpup() calls.
> - Remove syscon from L2 Cache. Force L2 Cache on if ECC enabled.
> - Convert to nested ECC in device tree.
> - Additional comments to clarify debug error injection.
>
> Thor Thayer (5):
>    arm: socfpga: Enable L2 Cache ECC on startup.
>    arm: socfpga: Enable OCRAM ECC on startup.
>    edac: altera: Remove SDRAM module compile
>    edac: altera: Add Altera L2 Cache and OCRAM EDAC Support
>    arm: dts: Add Altera L2 Cache and OCRAM EDAC entries
>
>   .../bindings/arm/altera/socfpga-edac.txt           |   46 ++
>   arch/arm/boot/dts/socfpga.dtsi                     |   20 +
>   arch/arm/mach-socfpga/Makefile                     |    2 +
>   arch/arm/mach-socfpga/core.h                       |    2 +
>   arch/arm/mach-socfpga/l2_cache.c                   |   39 ++
>   arch/arm/mach-socfpga/ocram.c                      |   97 ++++
>   arch/arm/mach-socfpga/socfpga.c                    |    4 +-
>   drivers/edac/Kconfig                               |   20 +-
>   drivers/edac/Makefile                              |    5 +-
>   drivers/edac/altera_edac.c                         |  506 +++++++++++++++++++-
>   10 files changed, 735 insertions(+), 6 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-edac.txt
>   create mode 100644 arch/arm/mach-socfpga/l2_cache.c
>   create mode 100644 arch/arm/mach-socfpga/ocram.c
>

From: monstr@monstr.eu (Michal Simek)
Date: Mon, 8 Jan 2018 13:34:00 +0100
Subject: [PATCH] soc: xilinx: Create folder structure for soc specific
 drivers
In-Reply-To: <c7bb89056326f42fb646ad00b27b841af3de69c1.1513689828.git.michal.simek@xilinx.com>
References: <c7bb89056326f42fb646ad00b27b841af3de69c1.1513689828.git.michal.simek@xilinx.com>
Message-ID: <e16b855f-17dc-f168-98ea-426a11e44b2a@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.12.2017 14:23, Michal Simek wrote:
> Create directory structure with Makefile/Kconfig for adding xilinx soc
> specific drivers.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> This patch is done based on discussion ended here
> https://lkml.org/lkml/2017/12/18/565
> 
> ---
>  drivers/soc/Kconfig         | 1 +
>  drivers/soc/Makefile        | 1 +
>  drivers/soc/xilinx/Kconfig  | 4 ++++
>  drivers/soc/xilinx/Makefile | 1 +
>  4 files changed, 7 insertions(+)
>  create mode 100644 drivers/soc/xilinx/Kconfig
>  create mode 100644 drivers/soc/xilinx/Makefile
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index fc9e98047421..c07b4a85253f 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -16,6 +16,7 @@ source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/ux500/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
> +source "drivers/soc/xilinx/Kconfig"
>  source "drivers/soc/zte/Kconfig"
>  
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index deecb16e7256..61c584d9d619 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -22,4 +22,5 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> +obj-y				+= xilinx/
>  obj-$(CONFIG_ARCH_ZX)		+= zte/
> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> new file mode 100644
> index 000000000000..ffaaa2f42c7e
> --- /dev/null
> +++ b/drivers/soc/xilinx/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menu "Xilinx SoC drivers"
> +
> +endmenu
> diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
> new file mode 100644
> index 000000000000..f66554cd5c45
> --- /dev/null
> +++ b/drivers/soc/xilinx/Makefile
> @@ -0,0 +1 @@
> +# SPDX-License-Identifier: GPL-2.0
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/2b9e98a4/attachment.sig>

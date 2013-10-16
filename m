From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 16 Oct 2013 13:57:32 -0400
Subject: [PATCH 2/2] ARM: vexpress: Enable platform-specific options in
 defconfig
In-Reply-To: <1381930594-1701-3-git-send-email-pawel.moll@arm.com>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
 <1381930594-1701-3-git-send-email-pawel.moll@arm.com>
Message-ID: <525ED38C.9040700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 10/16/2013 09:36 AM, Pawel Moll wrote:
> This patch enables all drivers and alike to make defconfig-ed
> kernels use Versatile Express specific features, like power
> management services (PSCI, MCPM and cpuidle with drivers for
> DCCSB on Fast Models and SPC on TC2), CMA for frame buffer
> allocation, all virtio device drivers (for QEMU, KVM tools
> and Fast Models), MTD physmap drivers with squashfs and UBIFS
> for flash, I2C master, regulator and hwmon drivers and
> LEDs support with most useful triggers. The maximum
> amount of CPUs has been increased to 8 to facilitate
> big.Little systems.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/configs/vexpress_defconfig | 65 ++++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
[...]
> @@ -121,21 +141,20 @@ CONFIG_EXT4_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
>  CONFIG_JFFS2_FS=y
> +CONFIG_UBIFS_FS=y
>  CONFIG_CRAMFS=y
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_LZO=y
>  CONFIG_NFS_FS=y
> -CONFIG_NFS_V3=y
>  CONFIG_ROOT_NFS=y

Isn't CONFIG_9P_FS=y needed for VirtIO passthrough filesystem support?

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

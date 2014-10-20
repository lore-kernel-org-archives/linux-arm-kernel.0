From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 20 Oct 2014 11:49:28 -0500
Subject: [PATCH 3/3] ARM: socfpga: enable INOTIFY_USER
In-Reply-To: <1413719582-16014-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1413719582-16014-1-git-send-email-s.trumtrar@pengutronix.de>
 <1413719582-16014-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CADhT+wewct1Gak+9zsqeei0CTYaQJkqA9v+j9CBiE0fkaEokyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On Sun, Oct 19, 2014 at 6:53 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:
> The defconfig has every options that are needed to boot a systemd-based
> user space apart from INOTIFY_USER.
>
> Enable it.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/configs/socfpga_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 40eaca055c85..f5a6af6a0de9 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -86,7 +86,7 @@ CONFIG_EXT2_FS_XATTR=y
>  CONFIG_EXT2_FS_POSIX_ACL=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_DNOTIFY is not set
> -# CONFIG_INOTIFY_USER is not set
> +CONFIG_INOTIFY_USER=y
>  CONFIG_VFAT_FS=y
>  CONFIG_NTFS_FS=y
>  CONFIG_NTFS_RW=y

I was about to send up a patch for an update of the defconfig.

diff --git a/arch/arm/configs/socfpga_defconfig
b/arch/arm/configs/socfpga_defconfig
index d7a5855..3037e39 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -93,8 +93,7 @@ CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
+CONFIG_INOTIFY_USER=y
 CONFIG_FHANDLE=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
@@ -123,3 +122,13 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC2_HOST=y
 CONFIG_USB_DWC2_PLATFORM=y
+CONFIG_SIGNALFD=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_SRAM=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_PMBUS=y
+CONFIG_SENSORS_PMBUS=y
+CONFIG_SENSORS_LTC2978=y
+CONFIG_SENSORS_LTC2978_REGULATOR=y
> --

Do you mind if I combine all 3 of your patches into 1 and add your
Signed-off-by?
IIRC, the ARM maintainers would like to avoid less churn of defconfig files as
much as possible?

Thanks,
Dinh

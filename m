From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Feb 2013 16:20:29 +0530
Subject: [PATCH 1/3] SPEAr13xx_defconfig: Enable Memory split 2G/2G needed
In-Reply-To: <6cebd9755011670ecaeec7930b3fa7ed0f16b3b6.1360317993.git.vijay.kumar@st.com>
References: <cover.1360317993.git.vijay.kumar@st.com>
 <6cebd9755011670ecaeec7930b3fa7ed0f16b3b6.1360317993.git.vijay.kumar@st.com>
Message-ID: <CAKohpokPhHtuDDBPUYp9YPOrEnaaKxthjiAemq74qfour_3aYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijay,

By mistake you have added an ST internal list in cc, fixed it now.

Subject should be:

ARM: SPEAr13xx: Enable 2G/2G Memory split in defconfig

On 8 February 2013 16:16, Vijay Kumar Mishra <vijay.kumar@st.com> wrote:
> Memory split 2G/2G is enabled as needed for SPEAr1310 RevC board to boot.
> Before enabling this option the boot was hanging at uncompressing linux.
> ---
>  arch/arm/configs/spear13xx_defconfig |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
> index 1fdb826..1b5ceff 100644
> --- a/arch/arm/configs/spear13xx_defconfig
> +++ b/arch/arm/configs/spear13xx_defconfig
> @@ -14,13 +14,13 @@ CONFIG_MACH_SPEAR1340=y
>  CONFIG_SMP=y
>  # CONFIG_SMP_ON_UP is not set
>  # CONFIG_ARM_CPU_TOPOLOGY is not set
> +CONFIG_VMSPLIT_2G=y
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_BINFMT_MISC=y
>  CONFIG_NET=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_MTD=y

> -CONFIG_MTD_OF_PARTS=y
> -# CONFIG_HID_SUPPORT is not set
> -# CONFIG_USB_DEVICE_CLASS is not set

Unrelated chages. Don't get them in next time. In case they
just got added automatically because you did and make savedefconfig,
do a make savedefconfig before any of these patches to make things
stable for all SPEAr SoCs. And then add these patches.

From: horms@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 18:08:47 +0900
Subject: [PATCH] ARM: mach-shmobile: mackerel: update defconfig
In-Reply-To: <1355559114-15523-1-git-send-email-horms@verge.net.au>
References: <1355559114-15523-1-git-send-email-horms@verge.net.au>
Message-ID: <20121215090847.GK9073@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 15, 2012 at 05:11:54PM +0900, Simon Horman wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> * Enable ARM_APPENDED_DTB
> 
>   Typically the bootloader of a mackerel board does not support DT
>   so this option is useful
> 
> * Add "rw" to command line
> 
>   This appears to be necessary for a successful NFS-root boot
> 
> * Do not disable INOTIFY_USER
> 
>   INOTIFY_USER is required by dbus which is common to many
>   userspaces

I seemed to miss the INOTIFY_USER portion of the change somehow,
I will repost.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/mackerel_defconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
> index 2098ce1..8519721 100644
> --- a/arch/arm/configs/mackerel_defconfig
> +++ b/arch/arm/configs/mackerel_defconfig
> @@ -23,7 +23,8 @@ CONFIG_AEABI=y
>  CONFIG_FORCE_MAX_ZONEORDER=15
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> -CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp memchunk.vpu=64m memchunk.veu0=8m memchunk.spu0=2m mem=240m"
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 earlyprintk=sh-sci.0,115200 root=/dev/nfs nfsroot=,tcp,v3 ip=dhcp memchunk.vpu=64m memchunk.veu0=8m memchunk.spu0=2m mem=240m rw"
>  CONFIG_KEXEC=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_PM=y
> -- 
> 1.7.10.4
> 

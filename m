From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Jan 2013 15:11:11 -0800
Subject: [PATCH 1/5] ARM: mach-shmobile: mackerel: update defconfig
In-Reply-To: <1357781039-14003-2-git-send-email-horms+renesas@verge.net.au>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
 <1357781039-14003-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130110231111.GA25944@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 10, 2013 at 10:23:55AM +0900, Simon Horman wrote:
> * Enable ARM_APPENDED_DTB
> 
>   Typically the bootloader of a mackerel board does not support DT
>   so this option is useful
> 
> * Add "rw" to command line
> 
>   This appears to be necessary for a successful NFS-root boot
> 
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

I don't think memchunk is used outside of arch/sh, so it can be dropped from
this default cmdline?

Also, with DTB, there's little use for an in-kernel default command line since
you can give one with the dtb instead. Perhaps just drop it alltogether and
move it there?


-Olof

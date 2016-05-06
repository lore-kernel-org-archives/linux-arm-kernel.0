From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 6 May 2016 16:30:10 +0200
Subject: [PATCH] ARM: at91: sama5: Update defconfig
In-Reply-To: <1462480295-8034-1-git-send-email-marex@denx.de>
References: <1462480295-8034-1-git-send-email-marex@denx.de>
Message-ID: <572CAA72.4000107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/05/2016 22:31, Marek Vasut a ?crit :
> Enable CGROUPS support, so we can boot userspace that uses systemd on
> top of kernel configured using this defconfig. The systemd userspace
> depends on cgroups and without them, it dies in mysterious ways.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi Marek,

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

BTW, isn't it something else required to run a systemd enabled image?
I've seen that some of the option may be missing as well:

CONFIG_FHANDLE (libudev, mount and bind mount handling)
from: https://github.com/systemd/systemd/blob/master/README#L51

In the " Optional but strongly recommended:" I see interest in:
 CONFIG_AUTOFS4_FS
 CONFIG_TMPFS_XATTR
 CONFIG_{TMPFS,EXT4,XFS,BTRFS_FS,...}_POSIX_ACL

But it's maybe not so interesting for our little embedded systems.

I'm also puzzled about the need for more options about cgroups...

I add a couple of other people in Cc so we can figure out the proper
configuration set...

Thanks Marek for having started the discussion, bye,

> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index afbda41..1b60be2 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -3,6 +3,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_IRQ_DOMAIN_DEBUG=y
>  CONFIG_LOG_BUF_SHIFT=14
> +CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EMBEDDED=y
>  CONFIG_SLAB=y
> 


-- 
Nicolas Ferre

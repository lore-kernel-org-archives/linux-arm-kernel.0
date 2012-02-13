From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 16:16:29 -0600
Subject: [PATCH 14/15] ARM: remove bunch of now unused mach/io.h files
In-Reply-To: <1329169408-17253-15-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-15-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EB5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
>
> Now that many platforms don't need mach/io.h, remove the usused ones.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---

<snip>

arch/arm/mach-ep93xx/include/mach/io.h    |   22 -------------

<snip>

 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h

<snip>

> diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
> deleted file mode 100644
> index 594b77f..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/io.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/io.h
> - */
> -
> -#ifndef __ASM_MACH_IO_H
> -#define __ASM_MACH_IO_H
> -
> -#define IO_SPACE_LIMIT		0xffffffff
> -
> -#define __io(p)			__typesafe_io(p)
> -#define __mem_pci(p)		(p)
> -

As I mentioned in Patch 11/15, the following chunk:

> -/*
> - * A typesafe __io() variation for variable initialisers
> - */
> -#ifdef __ASSEMBLER__
> -#define IOMEM(p)		p
> -#else
> -#define IOMEM(p)		((void __iomem __force *)(p))
> -#endif

should be in Patch 11/15 so that git bisect works.

> -
> -#endif /* __ASM_MACH_IO_H */

Regards,
Hartley

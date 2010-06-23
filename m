From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jun 2010 20:48:43 +0100
Subject: [PATCH 1/6] [ARM] Make common definition for IO_SPACE_LIMIT
In-Reply-To: <1277293938-25804-2-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
	<1277293938-25804-2-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20100623194843.GA25070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 07:52:13PM +0800, Eric Miao wrote:
> diff --git a/arch/arm/mach-ebsa110/include/mach/io.h b/arch/arm/mach-ebsa110/include/mach/io.h
> index f68daa6..44679db 100644
> --- a/arch/arm/mach-ebsa110/include/mach/io.h
> +++ b/arch/arm/mach-ebsa110/include/mach/io.h
> @@ -13,8 +13,6 @@
>  #ifndef __ASM_ARM_ARCH_IO_H
>  #define __ASM_ARM_ARCH_IO_H
>  
> -#define IO_SPACE_LIMIT 0xffff
> -
>  u8 __inb8(unsigned int port);
>  void __outb8(u8  val, unsigned int port);
>  
> diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
> index 101a4fe..c65ed51 100644
> --- a/arch/arm/mach-footbridge/include/mach/io.h
> +++ b/arch/arm/mach-footbridge/include/mach/io.h
> @@ -17,8 +17,6 @@
>  #define PCIO_SIZE		0x00100000
>  #define PCIO_BASE		0xff000000
>  
> -#define IO_SPACE_LIMIT 0xffff
> -
>  /*
>   * Translation of various region addresses to virtual addresses
>   */
> diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
> index f21bb54..37beed3 100644
> --- a/arch/arm/mach-integrator/include/mach/io.h
> +++ b/arch/arm/mach-integrator/include/mach/io.h
> @@ -20,8 +20,6 @@
>  #ifndef __ASM_ARM_ARCH_IO_H
>  #define __ASM_ARM_ARCH_IO_H
>  
> -#define IO_SPACE_LIMIT 0xffff
> -
>  /*
>   * WARNING: this has to mirror definitions in platform.h
>   */

These three are 0xffff because they are PCI, and the PCI IO window is
64K.  Allowing reservations above this value could cause problems.

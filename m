From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Mar 2013 23:43:23 +0000
Subject: [Suggestion] Latest randconfig build errors for Head.S
In-Reply-To: <51415428.1070401@asianux.com>
References: <51415428.1070401@asianux.com>
Message-ID: <20130314234323.GD4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 12:38:00PM +0800, Chen Gang wrote:
> Hello Maintainers:
> 
>   are these warnings for head.S OK ?
> 
> 
> make:
>   make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
>     (this time, CONFIG_MMU=y)
> 
> warning information:
>   arch/arm/boot/compressed/head.S: Assembler messages:
>   arch/arm/boot/compressed/head.S:565: Warning: (null)
>   arch/arm/boot/compressed/head.S:676: Warning: (null)
>   arch/arm/boot/compressed/head.S:698: Warning: (null)
>   arch/arm/boot/compressed/head.S:722: Warning: (null)
>   arch/arm/boot/compressed/head.S:726: Warning: (null)
>   arch/arm/boot/compressed/head.S:735: Warning: (null)
>   arch/arm/boot/compressed/head.S:978: Warning: (null)
>   arch/arm/boot/compressed/head.S:1017: Warning: (null)
>   arch/arm/boot/compressed/head.S:1018: Warning: (null)
>   arch/arm/boot/compressed/head.S:1048: Warning: (null)
>   arch/arm/boot/compressed/head.S:1055: Warning: (null)
>   arch/arm/boot/compressed/head.S:1063: Warning: (null)
>   arch/arm/boot/compressed/head.S:1074: Warning: (null)
>   arch/arm/boot/compressed/head.S:1088: Warning: (null)
>   arch/arm/boot/compressed/head.S:1120: Warning: (null)
>   arch/arm/boot/compressed/head.S:1122: Warning: (null)
>   arch/arm/boot/compressed/head.S:1123: Warning: (null)
>   arch/arm/boot/compressed/head.S:1130: Warning: (null)
>   arch/arm/boot/compressed/head.S:1162: Warning: (null)

*Sigh*

So our wonderful toolchain has decided to start producing NULL warnings
for every "mcr     p15, 0, rX, c7, c10, 4" instruction?  I'd just ignore
them and hope that the toolchain people fix it.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 10:29:23 +0100
Subject: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <1348152226-13588-2-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-2-git-send-email-mporter@ti.com>
Message-ID: <20120921092923.GA31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:43:34AM -0400, Matt Porter wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx atm) as well. This just moves
> the private EDMA API but does not support OMAP.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/common/Kconfig                    |    3 +
>  arch/arm/common/Makefile                   |    1 +
>  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
>  arch/arm/include/asm/mach/edma.h           |  267 +++++

asm/mach should not be used as a dumping ground for platform header files.
It is there to provide the interfaces between generic ARM architecture
code and platform code.  (At least four files that are there at the
moment need to be moved out of there - patch series to follow...)

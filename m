From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 16:01:03 +0100
Subject: [PATCH 3/3] Move MMCI header to amba include dir
In-Reply-To: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
References: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20090921150103.GB30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2009 at 10:55:27PM +0200, Linus Walleij wrote:
> This moves the mmci platform data definition struct away from
> arch/arm/include/asm/mach/mmc.h into the more proper place among
> the other primecells in include/linux/amba/mmci.h and at the same
> time renames it to "mmci.h", and also the struct in this file
> confusingly named mmc_platform_data has been renamed
> mmci_platform_data for clarity.

Not sure what's happened, but this patch appears to conflict with
another, resulting in:

arch/arm/mach-versatile/core.c:372: error: variable 'mmc0_plat_data' has initializer but incomplete type
arch/arm/mach-versatile/core.c:373: error: unknown field 'ocr_mask' specified in initializer
arch/arm/mach-versatile/core.c:373: warning: excess elements in struct initializer
arch/arm/mach-versatile/core.c:373: warning: (near initialization for 'mmc0_plat_data')
arch/arm/mach-versatile/core.c:374: error: unknown field 'status' specified in initializer
arch/arm/mach-versatile/core.c:374: warning: excess elements in struct initializer
arch/arm/mach-versatile/core.c:374: warning: (near initialization for 'mmc0_plat_data')
arch/arm/mach-versatile/core.c:375: error: unknown field 'gpio_wp' specified in initializer
arch/arm/mach-versatile/core.c:375: warning: excess elements in struct initializer
arch/arm/mach-versatile/core.c:375: warning: (near initialization for 'mmc0_plat_data')
arch/arm/mach-versatile/core.c:376: error: unknown field 'gpio_cd' specified in initializer
arch/arm/mach-versatile/core.c:376: warning: excess elements in struct initializer
arch/arm/mach-versatile/core.c:376: warning: (near initialization for 'mmc0_plat_data')

arch/arm/mach-realview/realview_eb.c:40:26: error: asm/mach/mmc.h: No such file or directory
arch/arm/mach-realview/realview_pb1176.c:40:26: error: asm/mach/mmc.h: No such file or directory
arch/arm/mach-realview/realview_pb11mp.c:41:26: error: asm/mach/mmc.h: No such file or directory

so I'm going to drop it for the time being.

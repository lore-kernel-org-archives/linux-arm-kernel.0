From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 22:26:26 +0000
Subject: [PATCH v2 07/28] ARM: iop13xx: move io.h externs to io.c
In-Reply-To: <4F4EA3C4.8000706@gmail.com>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201202292147.39302.arnd@arndb.de> <4F4EA3C4.8000706@gmail.com>
Message-ID: <201202292226.26654.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Rob Herring wrote:
> Look at the ULL defines:
> 
> #define IOP13XX_PCIX_MEM_PHYS_OFFSET  0x100000000ULL
> #define IOP13XX_PCIX_MEM_WINDOW_SIZE  0x3a000000UL
> #define IOP13XX_PCIX_LOWER_MEM_BA     (PHYS_OFFSET + IOP13XX_PCI_OFFSET)
> #define IOP13XX_PCIX_LOWER_MEM_PA     (IOP13XX_PCIX_MEM_PHYS_OFFSET +\
>                                        IOP13XX_PCIX_LOWER_MEM_BA)
> 
> There's also this discussion (search the page for iop13xx):
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/30905

Ok, got it. In that case I don't see a better alternative to your
patch anyway, especially since IOP13xx apparently predates
CONFIG_ARCH_PHYS_ADDR_T_64BIT and implemented the ioremap hack
in order to get around the same limitation. Changing this now for
a legacy platform is something I wouldn't want to try.

Thanks,

	Arnd

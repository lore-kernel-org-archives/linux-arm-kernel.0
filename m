From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Feb 2012 16:16:36 -0600
Subject: [PATCH v2 07/28] ARM: iop13xx: move io.h externs to io.c
In-Reply-To: <201202292147.39302.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <1330547147-22867-8-git-send-email-robherring2@gmail.com>
 <201202292147.39302.arnd@arndb.de>
Message-ID: <4F4EA3C4.8000706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I dropped some CC's as I'm getting bounced.

On 02/29/2012 03:47 PM, Arnd Bergmann wrote:
> On Wednesday 29 February 2012, Rob Herring wrote:
>>  arch/arm/mach-iop13xx/include/mach/io.h |    4 ----
>>  arch/arm/mach-iop13xx/io.c              |    5 +++++
>>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> Moving them out of io.h is good, but moving declarations into a .c file
> is rather bad style. It should remain in a header file that is visible to
> both io.c and pci.c. mach/pci.h would be an obvious choice.

Yes I know, but it was only in 1 place. I'll add a mach-iop13xx/pci.h.

> I'm also not sure if the iop13xx magic ioremap stuff is really needed
> and worth keeping. You mentioned in the description for patch 6 that
> it's used for 64 bit address mapping, but I can't see that in the code.
> Where did you find that information?
> 

Look at the ULL defines:

#define IOP13XX_PCIX_MEM_PHYS_OFFSET  0x100000000ULL
#define IOP13XX_PCIX_MEM_WINDOW_SIZE  0x3a000000UL
#define IOP13XX_PCIX_LOWER_MEM_BA     (PHYS_OFFSET + IOP13XX_PCI_OFFSET)
#define IOP13XX_PCIX_LOWER_MEM_PA     (IOP13XX_PCIX_MEM_PHYS_OFFSET +\
				       IOP13XX_PCIX_LOWER_MEM_BA)

There's also this discussion (search the page for iop13xx):
http://comments.gmane.org/gmane.linux.ports.arm.kernel/30905

Rob

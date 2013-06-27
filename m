From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 27 Jun 2013 08:30:40 +0800
Subject: [PATCH] arch: arm64: include: asm: add pci.h to pass compiling
In-Reply-To: <20130626140730.GB23309@arm.com>
References: <51CA5F71.207@asianux.com> <20130626140730.GB23309@arm.com>
Message-ID: <51CB87B0.8030805@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2013 10:07 PM, Catalin Marinas wrote:
> On Wed, Jun 26, 2013 at 04:26:41AM +0100, Chen Gang wrote:
>> > Need add pci.h for compiling, the related error (with allmodconfig):
>> > 
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_exit?:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declaration of function ?pci_free_consistent? [-Werror=implicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_init?:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declaration of function ?pci_alloc_consistent? [-Werror=implicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment makes pointer from integer without a cast [enabled by default]
>> >   cc1: some warnings being treated as errors
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/arm64/include/asm/pci.h |   11 +++++++++++
>> >  1 files changed, 11 insertions(+), 0 deletions(-)
>> >  create mode 100644 arch/arm64/include/asm/pci.h
>> > 
>> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> > new file mode 100644
>> > index 0000000..2ed467f
>> > --- /dev/null
>> > +++ b/arch/arm64/include/asm/pci.h
>> > @@ -0,0 +1,11 @@
>> > +#ifndef ASMARM64_PCI_H
>> > +#define ASMARM64_PCI_H
>> > +
>> > +#ifdef __KERNEL__
>> > +
>> > +#include <asm-generic/pci-dma-compat.h>
>> > +#include <asm-generic/pci.h>
>> > +
>> > +#endif /* __KERNEL__ */
>> > +
>> > +#endif
> I wonder whether it makes sense to include pci-dma-compat.h in
> asm-generic/pci.h, I don't see why one would want the generic pci.h but
> not the generic pci-dma-compat.h (cc'ing Arnd).

I think, it will let architecture guys easier to add their own
pci-dma-compat.h (although they still need generic pci_dma_compat.h, and
generic pci.h, too).

e.g. one architecture want include generic pci-dma-compat.h firstly,
then define its own features in its own pci-dma-compat.h.

Thanks.
-- 
Chen Gang

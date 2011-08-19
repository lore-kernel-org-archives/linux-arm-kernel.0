From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 19 Aug 2011 11:29:00 +0800
Subject: [PATCH] ARM: mach-orion5x: add missing header file <video/vga.h>
In-Reply-To: <CAK5ve-+x_u81gU__dEL1aVMuvXGG3=wzLsAf7z6PQrfKhnY-Ag@mail.gmail.com>
References: <CAK5ve-+x_u81gU__dEL1aVMuvXGG3=wzLsAf7z6PQrfKhnY-Ag@mail.gmail.com>
Message-ID: <CAK5ve-+V+BhsM7z3BZ=fguzizVjRyT55B4E0shm9hJJqwB6W5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell

I think this patch is required, need I submit it to patch system.

-Bryan

On Wed, Aug 17, 2011 at 5:57 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> Sorry, title is wrong. It should be <video/vga.h>
>
> -Bryan
>
> On Wed, Aug 17, 2011 at 5:29 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
>> This patch fixed following building error:
>> --
>> arch/arm/mach-orion5x/pci.c: In function 'orion5x_pci_sys_setup':
>> arch/arm/mach-orion5x/pci.c:563:2: error: 'vga_base' undeclared (first use in this function)
>> arch/arm/mach-orion5x/pci.c:563:2: note: each undeclared identifier is reported only once for each function it appears in
>> make[1]: *** [arch/arm/mach-orion5x/pci.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> --
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> ?arch/arm/mach-orion5x/pci.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
>> index 28b8760..bc4a920 100644
>> --- a/arch/arm/mach-orion5x/pci.c
>> +++ b/arch/arm/mach-orion5x/pci.c
>> @@ -14,6 +14,7 @@
>> ?#include <linux/pci.h>
>> ?#include <linux/slab.h>
>> ?#include <linux/mbus.h>
>> +#include <video/vga.h>
>> ?#include <asm/irq.h>
>> ?#include <asm/mach/pci.h>
>> ?#include <plat/pcie.h>
>> --
>> 1.7.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
>
> --
> Bryan Wu <bryan.wu@canonical.com>
> Kernel Developer ? ?+86.138-1617-6545 Mobile
> Ubuntu Kernel Team
> Canonical Ltd. ? ? ?www.canonical.com
> Ubuntu - Linux for human beings | www.ubuntu.com
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com

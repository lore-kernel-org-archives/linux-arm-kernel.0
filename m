From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 25 May 2010 11:36:44 +0300
Subject: [PATCH 6/6] [ARM] pxa/cm-x2xx: encode IRQ number into .nr_irqs
In-Reply-To: <AANLkTildk7al5cPAGDIiCnDNM7xg0Bl587F5e7fIiqof@mail.gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>	
	<1274682949-25915-7-git-send-email-eric.y.miao@gmail.com>	
	<4BFA2BD1.5040005@compulab.co.il>
	<AANLkTildk7al5cPAGDIiCnDNM7xg0Bl587F5e7fIiqof@mail.gmail.com>
Message-ID: <4BFB8C1C.5000408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Eric Miao wrote:
> Should be in my irq_cleanup branch, test welcome

works with the below patch on top your irq_cleanup branch:

-
From: Mike Rapoport <mike@compulab.co.il>
Date: Tue, 25 May 2010 11:28:08 +0300
Subject: [PATCH] [ARM] it8152: update interrupts numbering to work with 
sparse irqs

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
  arch/arm/include/asm/hardware/it8152.h |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hardware/it8152.h 
b/arch/arm/include/asm/hardware/it8152.h
index 6700c7f..b2f95c7 100644
--- a/arch/arm/include/asm/hardware/it8152.h
+++ b/arch/arm/include/asm/hardware/it8152.h
@@ -75,7 +75,8 @@ extern unsigned long it8152_base_address;
    IT8152_PD_IRQ(1)  USB (USBR)
    IT8152_PD_IRQ(0)  Audio controller (ACR)
   */
-#define IT8152_IRQ(x)   (IRQ_BOARD_END + (x))
+#define IT8152_IRQ(x)   (IRQ_BOARD_START + (x))
+#define IT8152_LAST_IRQ	(IRQ_BOARD_START + 40)

  /* IRQ-sources in 3 groups - local devices, LPC (serial), and external 
PCI */
  #define IT8152_LD_IRQ_COUNT     9
-- 
1.6.4.4

>> On May 24, 2010 3:34 PM, "Mike Rapoport" <mike@compulab.co.il 
>> <mailto:mike@compulab.co.il>> wrote:
>>
>> Hi Eric,
>>
>>
>>
>> Eric Miao wrote:
>> >
>> > Cc: Mike Rapoport <mike at compulab.co.il <mailto:mike@compulab.co.il>>
>> > Signed-off-by: Eric Miao <eric.y.mi...
>>
>> Looks Ok to me. Do you have a tree I can pull to test your changes?
>>
>>
>>
>> > diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.h 
>> b/arch/arm/mach-pxa/cm-x2xx-pci.h
>> > index e24aad2.....
>>
>> Sincerely yours,
>> Mike.
> 


-- 
Sincerely yours,
Mike.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-ARM-it8152-update-interrupts-numbering-to-work-with-.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100525/48b3b51a/attachment.el>

From: eric@anholt.net (Eric Anholt)
Date: Fri, 08 Apr 2016 11:37:23 -0700
Subject: [PATCH 0/3] dmaengine: bcm2835: support dma channel 11 to 14
In-Reply-To: <20160405170336.GB5392@vkoul-mobl.iind.intel.com>
References: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
 <20160405170336.GB5392@vkoul-mobl.iind.intel.com>
Message-ID: <87zit4ymjg.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Thu, Mar 17, 2016 at 03:24:30PM +0000, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Right now the dma engine officially supports dma channel 11 and 12.
>> But the use of dma channel 12 immediately stalls the system.
>> 
>> The reason is that the interrupt assigned right now to dma channel 11
>> is actually a shared interrupt for dma channels 11 to 12.
>> So whenever the dma channel 12, 13 or 14 is used, it triggers the interrupt
>> for dma 11 which only clears the interrupt flag for dma channel 11.
>> This results in the interrupt 11 is triggered all the time.
>> 
>> On top the requesting dma channel12 (and the corresponding irq) triggers
>> an immeditate stall of the system, because for the 12th interrupt
>> any dma channel will trigger also this interrupt - even if the dma channel
>> is controlled by the firmware.
>> 
>> As the description in the default device-tree is (for the above reasons)
>> wrong a new means had to get devised that allows correct representation
>> of the mapping between interrupts and dma channels.
>> 
>> For this the existing (but unused) device-tree property "interrupt-names"
>> is used to define the mapping.
>
> This looks fine by me, need an ACK on ARM patch before this can be applied.

This series is:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160408/ff8c6ca6/attachment.sig>

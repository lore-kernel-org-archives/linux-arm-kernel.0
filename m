From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 20 Apr 2016 13:06:15 +0200
Subject: [PATCH V2 2/3] dmaengine: bcm2835: use platform_get_irq_byname
In-Reply-To: <CAMuHMdW2Jw5=f9ojNSM0d1cGvPc6_QxwH4rcQdWBQTP89zyj4Q@mail.gmail.com>
References: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
 <1460381349-14408-3-git-send-email-kernel@martin.sperl.org>
 <CAMuHMdW2Jw5=f9ojNSM0d1cGvPc6_QxwH4rcQdWBQTP89zyj4Q@mail.gmail.com>
Message-ID: <571762A7.7000005@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20.04.2016 08:51, Geert Uytterhoeven wrote:
> On Mon, Apr 11, 2016 at 3:29 PM,  <kernel@martin.sperl.org> wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Use platform_get_irq_byname to allow for correct mapping of
>> interrupts to dma channels.
>>
>> The currently implemented device tree is unfortunately
>> implemented with the wrong assumption, that each dma-channel
>> has its own dma channel, but dma-irq 11 is handling
>> dma-channel 11-14 and dma-irq 12 is actually a "catch all"
>> interrupt.
>>
>> So here we use the byname variant and require that interrupts
>> are explicitly named via the interrupts-name property in the
>
> interrupt-names


Vinod has just merged this patch - do you want me to submit another
to correct those?

> You're not explicitly looking for "dma-shared-all" for that?
> You might as well just declare a single unnamed interrupt in the bindings.

dma-shared-all is unfortunately an interrupt-line that triggers
for interrupt-channels 0-15 and that includes the dma channels
that are owned by the firmware.

It is there mostly to document the interrupt-line (which is there in the 
existing device tree files - it is not used.

Martin

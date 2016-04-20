From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 13:12:36 +0200
Subject: [PATCH V2 2/3] dmaengine: bcm2835: use platform_get_irq_byname
In-Reply-To: <571762A7.7000005@martin.sperl.org>
References: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
 <1460381349-14408-3-git-send-email-kernel@martin.sperl.org>
 <CAMuHMdW2Jw5=f9ojNSM0d1cGvPc6_QxwH4rcQdWBQTP89zyj4Q@mail.gmail.com>
 <571762A7.7000005@martin.sperl.org>
Message-ID: <CAMuHMdUgfyLrdmfHLHd3eNh79FcJarVPuhbxtU4XYZok=skLkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Wed, Apr 20, 2016 at 1:06 PM, Martin Sperl <kernel@martin.sperl.org> wrote:
> On 20.04.2016 08:51, Geert Uytterhoeven wrote:
>>
>> On Mon, Apr 11, 2016 at 3:29 PM,  <kernel@martin.sperl.org> wrote:
>>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> Use platform_get_irq_byname to allow for correct mapping of
>>> interrupts to dma channels.
>>>
>>> The currently implemented device tree is unfortunately
>>> implemented with the wrong assumption, that each dma-channel
>>> has its own dma channel, but dma-irq 11 is handling
>>> dma-channel 11-14 and dma-irq 12 is actually a "catch all"
>>> interrupt.
>>>
>>> So here we use the byname variant and require that interrupts
>>> are explicitly named via the interrupts-name property in the
>>
>> interrupt-names
>
> Vinod has just merged this patch - do you want me to submit another

Yeah, that's how I noticed by accident :-)

> to correct those?

For the commit message it's indeed too late. For the error message in the
code, yes please.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

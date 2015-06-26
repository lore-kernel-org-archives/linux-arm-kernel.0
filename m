From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jun 2015 09:15:34 +0200
Subject: [PATCH v2] ARM: l2c: Add support for the "arm,
 shared-override" property
In-Reply-To: <558C7068.7070105@hauke-m.de>
References: <1430990831-23825-1-git-send-email-geert+renesas@glider.be>
 <20150507160257.GA11067@e104818-lin.cambridge.arm.com>
 <20150515101028.GH2067@n2100.arm.linux.org.uk>
 <20150515135513.GH19345@e104818-lin.cambridge.arm.com>
 <556D593C.1090002@monstr.eu> <558C7068.7070105@hauke-m.de>
Message-ID: <CAMuHMdV8MhkOP+cfZx1HHaOctccrGmKp9RQBLuqy-NS1SQCh8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke,

On Thu, Jun 25, 2015 at 11:19 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 06/02/2015 09:20 AM, Michal Simek wrote:
>> On 05/15/2015 03:55 PM, Catalin Marinas wrote:
>>> On Fri, May 15, 2015 at 11:10:28AM +0100, Russell King - ARM
>>> Linux wrote:
>>>> On Thu, May 07, 2015 at 05:02:57PM +0100, Catalin Marinas
>>>> wrote:
>>>>> On Thu, May 07, 2015 at 11:27:11AM +0200, Geert Uytterhoeven
>>>>> wrote:
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt
>>>>>> b/Documentation/devicetree/bindings/arm/l2cc.txt index
>>>>>> 0dbabe9a6b0abb91..2484aed78c86546d 100644 ---
>>>>>> a/Documentation/devicetree/bindings/arm/l2cc.txt +++
>>>>>> b/Documentation/devicetree/bindings/arm/l2cc.txt @@ -67,6
>>>>>> +67,12 @@ Optional properties: disable if zero. -
>>>>>> arm,prefetch-offset : Override prefetch offset value. Valid
>>>>>> values are 0-7, 15, 23, and 31. +- arm,shared-override :
>>>>>> The default behavior of the pl310 cache controller with +
>>>>>> respect to the shareable attribute is to transform "normal
>>>>>> memory +  non-cacheable transactions" into "cacheable no
>>>>>> allocate" (for reads) or +  "write through no write
>>>>>> allocate" (for writes). +  On systems where this may cause
>>>>>> DMA buffer corruption, this property must be +  specified
>>>>>> to indicate that such transforms are precluded.

>>>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> I do not see this in linux-next, and would like to use this.
>
> Geert have you submitted this through this patch submission page?
> http://www.arm.linux.org.uk/developer/patches/

Thanks for reminding me!

Submitted with Catalin's Acked-by.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

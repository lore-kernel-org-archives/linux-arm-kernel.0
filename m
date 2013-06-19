From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 21:50:35 +0200
Subject: [RFC PATCH 11/11] ARM: s3c64xx: Add support for DMA using generic
 amba-pl08x driver
In-Reply-To: <91444857.CpeBVZzDHZ@flatron>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-12-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdbQ7+FDJh235vERbCcQcnW1Mzar9r5jgLaXAT5n6CiCFQ@mail.gmail.com>
 <91444857.CpeBVZzDHZ@flatron>
Message-ID: <CACRpkdYqNgLZhJ3oPZcCPjWExjWC+1WzPY2kka4uKCKkLwuu_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 8:23 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 17 of June 2013 16:04:47 Linus Walleij wrote:
>> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com>
> wrote:
>> > +static AMBA_AHB_DEVICE(s3c64xx_dma1, "dma-pl080s.1", 0x0a141080,
>> > +                       0x75100000, {IRQ_DMA1},
>> > &s3c64xx_dma1_plat_data);
>> Ah, does this mean the device does not have any AMBA PrimeCell ID
>> contents?
>
> Hmm, not really. The ID here is what I copied from PrimeCell ID registers
> and the method of registration is taken from S5PV210. If I remove the
> override, it will read the same value from registers.

OK then don't override. Overriding is for hardware which is all zeroes
in these registers.

>> Then use the ID 0x00053080 instead of 0x0a141080
>>
>> 0x53 is "S" for Samsung. Variant 0.
>
> Well, that's kind of solution to make sure that it won't conflict with any
> future variant manufactured by ARM, I guess.

Yeah, but as stated, if the hardware has proper IDs (these are
probably inspired by the PCI vendor/device/revision fields)
then rely on those.

Yours,
Linus Walleij

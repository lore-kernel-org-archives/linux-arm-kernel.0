From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 13:34:03 +0200
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l,
 ldr_l and str_l macros
In-Reply-To: <20160804113018.GH7147@e103592.cambridge.arm.com>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803180934.GK1041@n2100.armlinux.org.uk>
 <CAKv+Gu9Wyiu38J=K00WKXSeFoDF2vS-3TJAvbz9Yo616GBXSwQ@mail.gmail.com>
 <20160804093851.GD7147@e103592.cambridge.arm.com>
 <CAKv+Gu8_5-VcBxnjLrJxgKcJfVFb785qvVzbB6kryqhhkCfQbA@mail.gmail.com>
 <20160804110832.GF7147@e103592.cambridge.arm.com>
 <CAKv+Gu_JVX3erz6N64EGfu38TDi6PHsQVGY=nkfu7kF-8Hq=6Q@mail.gmail.com>
 <20160804113018.GH7147@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_r4Rx=pvZWNaE1f-_QDiwyn62uS+MzPyNUqndE5jCS2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2016 at 13:30, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Aug 04, 2016 at 01:10:55PM +0200, Ard Biesheuvel wrote:
>> On 4 August 2016 at 13:08, Dave Martin <Dave.Martin@arm.com> wrote:
>
> [...]
>
>> > or, for ldr_l:
>> >
>> > 0:      add     \dst, pc, #-8
>> > 1:      add     \dst, \dst, #-4
>> > 2:      ldr     [\dst, #0]
>> >
>> > .reloc  0b, R_ARM_ALU_PC_G0_NC, \sym
>> > .reloc  1b, R_ARM_ALU_PC_G1_NC, \sym
>> > .reloc  2b, R_ARM_LDR_PC_G2, \sym
>> >
>> > ... should produce precisely the same result at the .o stage.
>> >
>>
>> Yes, but how is LD going to perform the arithmetic involved in
>
> What arithmetic?
>

The arithmetic involved in populating the immediate fields of these
instructions based on the actual offset between the Place and the
Symbol in the final image.

>> handling these relocations? That's is the more interesting part, and
>> that is not implemented either in binutils < 2.18
>
> You mean .reloc is not implemented < 2.18?
>

Yes, .reloc is implemented, but that is not sufficient.

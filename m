From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Nov 2015 12:14:39 +0100
Subject: [PATCH] arm64: mm: use correct mapping granularity under
 DEBUG_RODATA
In-Reply-To: <20151117111137.GG6556@e104818-lin.cambridge.arm.com>
References: <1447669094-31076-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151116115740.GD20696@leverpostej>
 <CAKv+Gu9ZoRx8i8ppNxiuS9FfRONzLK5TVPe33W-dirfO702zOQ@mail.gmail.com>
 <20151116121628.GG20696@leverpostej>
 <CAKv+Gu9oeuF-5Q=EoD+=QTAh6mk1QDD1QfffN21zoELhsfO1wA@mail.gmail.com>
 <20151117111137.GG6556@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8577XJRij3hEdb0_g47y1hL-zvHnzuZbB8WVfPoTYZTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2015 at 12:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Nov 16, 2015 at 01:18:47PM +0100, Ard Biesheuvel wrote:
>> On 16 November 2015 at 13:16, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> > Does this need to be backported to stable?
>> >>
>> >> It should be fixed in stable, I think, but SWAPPER_BLOCK_SIZE is new
>> >> in v4.4 so we'd need another patch anyway.
>> >
>> > I was hoping 87d1587bef394cd8 ("arm64: Move swapper pagetable
>> > definitions") would backport easily. I just had a go and that's not the
>> > case, and the conflict is non-trivial.
>> >
>> > Regardless, we should probably mark this with a fixes tag so it doesn't
>> > get lost:
>> >
>> > Fixes: da141706aea52c1a ("arm64: add better page protections to arm64")
>>
>> Indeed.
>>
>> For the backported version, we can just add a #define
>> SWAPPER_BLOCK_SIZE to mmu.c
>
> Patch applied with a fixes tag. I assume you'll prepare a fix for stable
> when Greg pings us.
>

Indeed. We should pay attention, though, since the patch most likely
applies cleanly to older kernels, and will only break at build time
for lack of a definition of SWAPPER_BLOCK_SIZE.

-- 
Ard.

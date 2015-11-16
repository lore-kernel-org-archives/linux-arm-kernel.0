From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 13:18:47 +0100
Subject: [PATCH] arm64: mm: use correct mapping granularity under
 DEBUG_RODATA
In-Reply-To: <20151116121628.GG20696@leverpostej>
References: <1447669094-31076-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151116115740.GD20696@leverpostej>
 <CAKv+Gu9ZoRx8i8ppNxiuS9FfRONzLK5TVPe33W-dirfO702zOQ@mail.gmail.com>
 <20151116121628.GG20696@leverpostej>
Message-ID: <CAKv+Gu9oeuF-5Q=EoD+=QTAh6mk1QDD1QfffN21zoELhsfO1wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 13:16, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Does this need to be backported to stable?
>>
>> It should be fixed in stable, I think, but SWAPPER_BLOCK_SIZE is new
>> in v4.4 so we'd need another patch anyway.
>
> I was hoping 87d1587bef394cd8 ("arm64: Move swapper pagetable
> definitions") would backport easily. I just had a go and that's not the
> case, and the conflict is non-trivial.
>
> Regardless, we should probably mark this with a fixes tag so it doesn't
> get lost:
>
> Fixes: da141706aea52c1a ("arm64: add better page protections to arm64")
>

Indeed.

For the backported version, we can just add a #define
SWAPPER_BLOCK_SIZE to mmu.c

-- 
Ard.

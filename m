From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Nov 2015 12:16:29 +0000
Subject: [PATCH] arm64: mm: use correct mapping granularity under
 DEBUG_RODATA
In-Reply-To: <CAKv+Gu9ZoRx8i8ppNxiuS9FfRONzLK5TVPe33W-dirfO702zOQ@mail.gmail.com>
References: <1447669094-31076-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151116115740.GD20696@leverpostej>
 <CAKv+Gu9ZoRx8i8ppNxiuS9FfRONzLK5TVPe33W-dirfO702zOQ@mail.gmail.com>
Message-ID: <20151116121628.GG20696@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Does this need to be backported to stable?
> 
> It should be fixed in stable, I think, but SWAPPER_BLOCK_SIZE is new
> in v4.4 so we'd need another patch anyway.

I was hoping 87d1587bef394cd8 ("arm64: Move swapper pagetable
definitions") would backport easily. I just had a go and that's not the
case, and the conflict is non-trivial.

Regardless, we should probably mark this with a fixes tag so it doesn't
get lost:

Fixes: da141706aea52c1a ("arm64: add better page protections to arm64")

Mark.

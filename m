From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 18:22:03 +0000
Subject: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate
 kernel addresses
In-Reply-To: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
References: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
Message-ID: <20181127182203.GA19721@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Nov 23, 2018 at 06:29:02PM +0100, Ard Biesheuvel wrote:
> On arm64, all executable code is guaranteed to reside in the vmalloc
> space (or the module space), and so jump targets will only use 48
> bits at most, and the remaining bits are guaranteed to be 0x1.
> 
> This means we can generate an immediate jump address using a sequence
> of one MOVN (move wide negated) and two MOVK instructions, where the
> first one sets the lower 16 bits but also sets all top bits to 0x1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Denial, Alexei, shall I take this via arm64, or would you rather take
it via davem?

Cheers,

Will

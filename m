From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Oct 2015 17:25:36 +0000
Subject: [PATCH] arm64: page-align sections for DEBUG_RODATA
In-Reply-To: <20151027105632.GA3091@leverpostej>
References: <1445895753-2095-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu-jCxeQt1DffTnYiMLT-jB75GiQCOUR7GqNH7hAeB84LA@mail.gmail.com>
 <20151027105632.GA3091@leverpostej>
Message-ID: <20151029172536.GT8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 10:56:33AM +0000, Mark Rutland wrote:
> On Tue, Oct 27, 2015 at 11:37:04AM +0900, Ard Biesheuvel wrote:
> > On 27 October 2015 at 06:42, Mark Rutland <mark.rutland@arm.com> wrote:
> > > A kernel built with DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA doesn't
> > > have .text aligned to a page boundary, though fixup_executable works at
> > > page-granularity thanks to its use of create_mapping. If .text is not
> > > page-aligned, the first page it exists in may be marked non-executable,
> > > leading to failures when an attempt is made to execute code in said
> > > page.
> > >
> > > This patch upgrades ALIGN_DEBUG_RO and ALIGN_DEBUG_RO_MIN to force page
> > > alignment for DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA kernels,
> > > ensuring that all sections with specific RWX permission requirements are
> > > mapped with the correct permissions.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Reviewed-by: Laura Abbott <laura@labbott.name>
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
[...]
> Jeremy, does this work for you?
> 
> If so, I expect Catalin will take this for 4.4, with the addition of any
> Acks and:
> 
> Fixes: da141706aea52c1a ("arm64: add better page protections to arm64")
> Cc: <stable@vger.kernel.org>

I applied this patch. I haven't pushed it out yet, in case Jeremy wants
to add any acked/tested-by tags.

Thanks.

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Aug 2017 13:22:26 +0100
Subject: [PATCH 0/5] Simplify kernel-mode NEON
In-Reply-To: <20170804120858.ff3772f3zzik37pp@armageddon.cambridge.arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
 <20170804120858.ff3772f3zzik37pp@armageddon.cambridge.arm.com>
Message-ID: <20170804122225.jiceb2vbgrld2y7z@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 01:08:58PM +0100, Catalin Marinas wrote:
> On Thu, Aug 03, 2017 at 05:23:18PM +0100, Dave P Martin wrote:
> > This series depends on Ard's v4.14 crypto rework [2].
[...]
> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520664.html
[...]
> > Ard Biesheuvel (1):
> >   arm64: neon: replace generic definition of may_use_simd()
> > 
> > Dave Martin (4):
> >   arm64: neon: Add missing header guard in <asm/neon.h>
> >   arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
> >   arm64: neon: Allow EFI runtime services to use FPSIMD in irq context
> >   arm64: neon: Remove support for nested or hardirq kernel-mode NEON
> 
> Queued for 4.14. Thanks.

... and reverted.

I now realised that it doesn't build without Ard's crypto series (I had
the wrong impression it is just a performance impact). I get errors
like:

arch/arm64/crypto/sha1-ce-glue.c|41 col 2| error: implicit declaration
of function ?kernel_neon_begin_partial?

-- 
Catalin

From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 9 Jan 2017 14:56:30 +0000
Subject: [PATCH] arm64: head.S: fix up stale comments
In-Reply-To: <CAKv+Gu_t7n8PUAeAYe2kkFpPciC0eJ+Qg7sHu_tTfux=3LwyTg@mail.gmail.com>
References: <1483972315-12782-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu_t7n8PUAeAYe2kkFpPciC0eJ+Qg7sHu_tTfux=3LwyTg@mail.gmail.com>
Message-ID: <20170109145630.GA13104@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 02:55:51PM +0000, Ard Biesheuvel wrote:
> On 9 January 2017 at 14:31, Mark Rutland <mark.rutland@arm.com> wrote:
> > In commit 23c8a500c24d02dd ("arm64: kernel: use ordinary return/argument
> > register for el2_setup()"), we stopped using w20 as a global stash of
> > the boot mode flag, and instead pass this around in w0 as a function
> > parameter.
> >
> > Unfortunately, we missed a couple of comments, which still refer to the
> > old convention of using w20/x20.
> >
> > This patch fixes up the comments to describe the code as it currently
> > works.
> >
> 
> Ah yes, apologies for the sloppiness

No worries; I missed this in review, too...

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Cheers!

Mark.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/head.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 4b1abac..9b0857a 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -483,7 +483,7 @@ ENTRY(kimage_vaddr)
> >   * If we're fortunate enough to boot at EL2, ensure that the world is
> >   * sane before dropping to EL1.
> >   *
> > - * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in x20 if
> > + * Returns either BOOT_CPU_MODE_EL1 or BOOT_CPU_MODE_EL2 in w0 if
> >   * booted in EL1 or EL2 respectively.
> >   */
> >  ENTRY(el2_setup)
> > @@ -628,7 +628,7 @@ ENDPROC(el2_setup)
> >
> >  /*
> >   * Sets the __boot_cpu_mode flag depending on the CPU boot mode passed
> > - * in x20. See arch/arm64/include/asm/virt.h for more info.
> > + * in w0. See arch/arm64/include/asm/virt.h for more info.
> >   */
> >  set_cpu_boot_mode_flag:
> >         adr_l   x1, __boot_cpu_mode
> > --
> > 1.9.1
> >

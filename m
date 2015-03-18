From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Mar 2015 18:05:02 +0000
Subject: [PATCH v5 2/8] arm64: add macros for common adrp usages
In-Reply-To: <CAKv+Gu-v37RPWB9S+n-j9cN3JffkE08ejSZY2CFEEje51ixHew@mail.gmail.com>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150318175429.GF19814@leverpostej>
 <CAKv+Gu-v37RPWB9S+n-j9cN3JffkE08ejSZY2CFEEje51ixHew@mail.gmail.com>
Message-ID: <20150318180502.GG19814@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 05:56:11PM +0000, Ard Biesheuvel wrote:
> On 18 March 2015 at 18:54, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Mar 18, 2015 at 02:55:21PM +0000, Ard Biesheuvel wrote:
> >> The adrp instruction is mostly used in combination with either
> >> an add, a ldr or a str instruction with the low bits of the
> >> referenced symbol in the 12-bit immediate of the followup
> >> instruction.
> >>
> >> Introduce the macros adr_l, ldr_l and str_l that encapsulate
> >> these common patterns.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> >> index 750bac4e637e..f1804d4803fb 100644
> >> --- a/arch/arm64/include/asm/assembler.h
> >> +++ b/arch/arm64/include/asm/assembler.h
> >> @@ -159,4 +159,33 @@ lr       .req    x30             // link register
> >>       orr     \rd, \lbits, \hbits, lsl #32
> >>       .endm
> >>
> >> +/*
> >> + * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
> >> + * <symbol> is within the range +/- 4 GB of the PC.
> >> + */
> >
> > It would be nice to point out that tmp for adr_l and ldr_l is only
> > necesssary when loading a value into the SP.
> >
> 
> For adr_l, it is for the sp.
> For ldr_l, it is primarily for being able to load w registers as well.

Ah, I hadn't considered that. Are you happy to add something to the
comment block mentioning those cases?

Thanks,
Mark.

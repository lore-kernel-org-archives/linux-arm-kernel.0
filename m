From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 11:30:42 +0000
Subject: [PATCH v6] ARM: Factor out cpuid implementor and part number
In-Reply-To: <CANM98qKfFXmKwn24O1=5+f538qWKmRUCHHsXMyYi6hK5JKmvoA@mail.gmail.com>
References: <1354407686-38366-1-git-send-email-c.dall@virtualopensystems.com>
 <CANM98qKfFXmKwn24O1=5+f538qWKmRUCHHsXMyYi6hK5JKmvoA@mail.gmail.com>
Message-ID: <20121217113042.GB10094@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 12:32:27AM +0000, Christoffer Dall wrote:
> On Sat, Dec 1, 2012 at 7:21 PM, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
> > Decoding the implementor and part number of the CPU id in the CPU ID
> > register is needed by KVM, so we factor it out to share the code.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> > ---
> > Changes since v5:
> >  - (OK, this is getting ridiculous, this time I forgot a git add):
> >    incorrect function declaration
> > Changes since v4:
> >  - Properly decode XScale cpu architecture versions
> > Changes since v3:
> >  - Only call read_cpuid_part_number once and squash warning
> > Changes since v2:
> >  - Take implementor as argument to read_cpuid_part_number
> > Changes since v1:
> >  - Accidentally pointed to an old file, this one has more consistent
> >    naming of the cpu implementor and part number defines.
> >
> >  arch/arm/include/asm/cputype.h   |   33 +++++++++++++++++++++++++++++++++
> >  arch/arm/kernel/perf_event_cpu.c |   34 ++++++++++++++++------------------
> >  2 files changed, 49 insertions(+), 18 deletions(-)
> 
> any news on this one?

If you resend as two patches (cputype.h first, then perf) and fix the
whitespace problem in the first (missing space after '&') then I'll put
them in my perf tree which will ultimately go via Russell.

Will

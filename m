From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 May 2015 13:41:55 +0100
Subject: [PATCHv3 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <CAJ5Y-eYpPXWEZpVxdnAytjHS0D+ufDoYQUo3yKqLbysCSGswSw@mail.gmail.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-eYpPXWEZpVxdnAytjHS0D+ufDoYQUo3yKqLbysCSGswSw@mail.gmail.com>
Message-ID: <20150527124155.GI8439@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 01:01:23PM +0100, Ashwin Chaugule wrote:
> On 26 May 2015 at 09:52, Mark Rutland <mark.rutland@arm.com> wrote:
> > Now that the common PSCI client code has been factored out to
> > drivers/firmware, and made safe for 32-bit use, move the 32-bit ARM code
> > over to it. This results in a moderate reduction of duplicated lines,
> > and will prevent further duplication as the PSCI client code is updated
> > for PSCI 1.0 and beyond.
> >
> > The two legacy platform users of the PSCI invocation code are updated to
> > account for interface changes. In both cases the power state parameter
> > is changed to an opaque u32 token in preparation for PSCI 1.0 power
> > state changes.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/Kconfig                  |   1 +
> >  arch/arm/include/asm/psci.h       |  23 ---
> >  arch/arm/kernel/Makefile          |   2 +-
> >  arch/arm/kernel/psci.c            | 299 --------------------------------------
> >  arch/arm/kernel/psci_smp.c        |  29 +++-
> >  arch/arm/kernel/setup.c           |   3 +-
> >  arch/arm/mach-highbank/highbank.c |   2 +-
> >  arch/arm/mach-highbank/pm.c       |   8 +-
> >  drivers/cpuidle/cpuidle-calxeda.c |   7 +-
> >  9 files changed, 32 insertions(+), 342 deletions(-)
> >  delete mode 100644 arch/arm/kernel/psci.c
> 
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

Cheers!

Mark.

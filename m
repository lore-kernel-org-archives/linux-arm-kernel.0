From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Jun 2015 10:45:30 +0100
Subject: [PATCHv3 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <20150603151625.GA599@leverpostej>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
 <20150603151625.GA599@leverpostej>
Message-ID: <20150604094529.GB8346@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jun 03, 2015 at 04:16:39PM +0100, Mark Rutland wrote:
> On Tue, May 26, 2015 at 02:52:29PM +0100, Mark Rutland wrote:
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
> Do you have any objections to the arch/arm changes in this patch?
> 
> If not, could I please have your ack?
> 
> As there are arm, arm64, and drivers changes in the series I was hoping
> this could all go via arm-soc.

If we don't hear from Russell by the end of today, I propose that we
merge patches 1-8 in the arm64 tree (mostly fixes for PSCI). This series
is blocking other developments like PSCI 1.0, so I really want to get
parts of it merged in 4.2.

BTW, can we skip patch 11 in this series and still allow
drivers/firmware/psci.c only for arm64, with the aim of moving the arm32
code later?

Thanks.

-- 
Catalin

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Jun 2015 10:49:21 +0100
Subject: [PATCHv3 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <20150603151625.GA599@leverpostej>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
 <20150603151625.GA599@leverpostej>
Message-ID: <20150604094921.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 04:16:39PM +0100, Mark Rutland wrote:
> Hi Russell,
> 
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

If you want me to do something, please ensure that you send stuff _To:_
me, not _Cc:_ me... I can't say when I'll be able to look at them today,
but hopefully tomorrow.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

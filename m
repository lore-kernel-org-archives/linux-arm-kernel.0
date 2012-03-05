From: jhovold@gmail.com (Johan Hovold)
Date: Mon, 5 Mar 2012 14:58:38 +0100
Subject: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
In-Reply-To: <4F4E4F1D.7020109@ti.com>
References: <4F4BB0FB.3040308@ti.com> <20120228234837.GH18901@atomide.com>
 <4F4E4F1D.7020109@ti.com>
Message-ID: <20120305135838.GA2108@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 05:15:25PM +0100, Cousson, Benoit wrote:
> On 2/29/2012 12:48 AM, Tony Lindgren wrote:
> > * Cousson, Benoit<b-cousson@ti.com>  [120227 08:04]:
> >> Hi Tony
> >>
> >> This series is based on the lo/dt + the irqdomain/next branch merged on top of it.
> >>
> >> Grant confirmed that the irqdomain/next is a stable branch and thus can be referenced for dependency.
> >>
> >> Please note that I will need that branch to base all the remaining OMAP DT stuff.
> >>
> >> Thanks,
> >> Benoit
> >>
> >>
> >> The following changes since commit 1f52299ec000e2161635b263d81ab92ea7f1f0a7:
> >>    Benoit Cousson (1):
> >>          Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 into for_3.4/dt_irq_domain2
> >>
> >> are available in the git repository at:
> >>
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_irq_domain
> >>
> >> Benoit Cousson (3):
> >>        ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
> >>        arm/dts: OMAP3: Add interrupt-controller bindings for INTC
> >>        ARM: OMAP2+: board-generic: Use of_irq_init API
> >>
> >>   .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
> >>   arch/arm/boot/dts/omap3.dtsi                       |    6 +-
> >>   arch/arm/mach-omap2/board-generic.c                |   30 +++++-----
> >>   arch/arm/mach-omap2/common.h                       |   12 ++++
> >>   arch/arm/mach-omap2/irq.c                          |   60 ++++++++++++++++---
> >>   5 files changed, 109 insertions(+), 26 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
> > 
> > Hmm, looks like this now produces the following warning at least on omap3:
> 
> Yes, Rajendra has just reported that issue with linux-next.

I'm getting the same warning and initialisation failure with 3.3-rc6 on
overo. Are these fixes queued up for 3.3 (and not just 3.4) somewhere?

Thanks,
Johan

From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 3 Oct 2011 10:40:31 +0800
Subject: [PATCH v4 0/7] add initial imx6q support
In-Reply-To: <201109302304.26953.arnd@arndb.de>
References: <1317200808-6275-1-git-send-email-shawn.guo@linaro.org>
	<201109302304.26953.arnd@arndb.de>
Message-ID: <20111003024030.GA21263@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 11:04:26PM +0200, Arnd Bergmann wrote:
> On Wednesday 28 September 2011, Shawn Guo wrote:
> > 
> > This patch series adds the initial support for imx6q, which is a
> > Cortex-A9 Quad Core based SoC.
> > 
> > We chose to add imx6q support into mach-imx other than mach-mx5 or
> > a new mach-mx6, because we intend to merge mach-mx5 into mach-imx, so
> > that we have only mach-imx for imx family.
> > 
> > It's based on linux-next-20110926 with some prerequisite patches
> > not showing up on linux-next applied.
> 
> How should we best proceed on this series? Sascha, do you want to
> take the next version into your tree once Shawn has addressed the
> remaining comments, or should I just take the patches with your
> Ack?
> 
> Shawn, what are the current dependencies? I will have to pull
> in the other branches that this depends on into the next/soc
> tree and then wait for those to get merged first before I send
> this to Linus.
> 
Thanks for asking, Arnd.

The latest version (v5) of this series that I will send shortly has
the dependencies on the following branches.

* rmk's for-next branch with the following additional patches wait for
  rmk to apply:
  - ARM: l2x0: add empty l2x0_of_init (Rob Herring)
  - ARM: cache-l2x0: add resume entry for l2 in secure mode (Barry Song)
  - ARM: localtimer: add header linux/errno.h explicitly (Shawn Guo)
  - ARM: smp: Add an IPI handler callable from C code (Marc Zyngier)
  - ARM: smp: Add a localtimer handler callable from C code (Shawn Guo)

* Rob Herring's "GIC OF bindings" series, currently on

    git://git.jdl.com/software/linux-3.0.git gic-v2

  tglx has picked up the two that are irq core related.  And I'm not
  sure about the branch that Rob will push others to.

* Branches that will be merged into arm-soc
  - Sascha's imx-cleanup
  - Sascha's imx-features
  - [GIT PULL] DEBUG_LL platform updates for 3.2 (Will Deacon)

-- 
Regards,
Shawn

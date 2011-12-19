From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 19 Dec 2011 13:45:23 +0000
Subject: Fw: [GIT PULL] Refactor common Kconfigs for easier maintenance
Message-ID: <20111219134523.GA2029@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Forwarding to alkml, which I missed off the original recipient list.
If you already received this mail, please ignore]

----- Forwarded message from Dave Martin <dave.martin@linaro.org> -----

Date: Mon, 19 Dec 2011 13:42:07 +0000
From: Dave Martin <dave.martin@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: patches at linaro.org, Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>, Anton Vorontsov <cbouatmailru@gmail.com>, Barry Song <baohua.song@csr.com>, Bryan Huntsman <bryanh@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Colin Cross <ccross@google.com>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Fabio Estevam <fabio.estevam@freescale.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn
	<john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring
	<rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>,
	linux-arm-msm at vger.kernel.org, linux-omap at vger.kernel.org, linux-samsung-soc at vger.kernel.org, linux-sh at vger.kernel.org, linux-tegra at vger.kernel.org
Subject: [GIT PULL] Refactor common Kconfigs for easier maintenance
X-Mailer: git-send-email 1.7.4.1

Hi Russell,

This series now has acks on the generic patches from a reasonable
cross-section of maintainers, and acks from relevant people on the
board-specifc patches, so if you're happy with it, could you pull
it into your tree?

If you have any concerns, let me know.

Thanks
---Dave

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.linaro.org/people/dmart/linux-2.6-arm.git arm/common-kconfig-refactor+for-rmk

Dave Martin (5):
      ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
      ARM: SMP: Refactor Kconfig to be more maintainable
      omap4: Unconditionally require l2x0 L2 cache controller support
      highbank: Unconditionally require l2x0 L2 cache controller support
      imx6q: Remove unconditional dependency on l2x0 L2 cache support

 arch/arm/Kconfig               |   26 ++++++++++++++++++++++----
 arch/arm/mach-exynos/Kconfig   |    2 ++
 arch/arm/mach-imx/Kconfig      |    2 +-
 arch/arm/mach-msm/Kconfig      |    1 +
 arch/arm/mach-omap2/Kconfig    |    2 ++
 arch/arm/mach-realview/Kconfig |    9 +++++++++
 arch/arm/mach-vexpress/Kconfig |    2 ++
 arch/arm/mm/Kconfig            |   23 ++++++++++++++++-------
 arch/arm/plat-mxc/Kconfig      |    1 +
 9 files changed, 56 insertions(+), 12 deletions(-)

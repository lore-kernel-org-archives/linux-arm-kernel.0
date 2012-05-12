From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:52 -0600
Subject: [PATCH 0/9] ARM: dt: tegra: cleanup pass
Message-ID: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

I've been wanting to clean up the Tegra .dts files for a little while.
Here's a set of changes to do so. Hopefully they don't seem to much
like churn.

I was thinking of putting them into a for-3.6/cleanup branch, but I
suppose I could put them into 3.5 at the end too. I'd need to base this
series on the result of merging Tegra's for-3.5/dt and
for-3.5/tegra30-audio branches. Olof, what are your thoughts here?

I've tested them on Cardhu so far, but still need to test all the other
boards to make sure I didn't introduce some typo.

Stephen Warren (9):
  ARM: dt: tegra: whitespace cleanup
  ARM: dt: tegra: remove unnecessary unit addresses
  ARM: dt: tegra: gpio comment cleanup
  ARM: dt: tegra: format regs properties consistently
  ARM: dt: tegra: consistenly use lower-case for hex constants
  ARM: dt: tegra: remove duplicate device_type property
  ARM: dt: tegra: sort nodes based on bus order
  ARM: dt: tegra: consistent basic property ordering
  ARM: dt: tegra: invert status=disable vs status=okay

 arch/arm/boot/dts/tegra-cardhu.dts    |   62 ++-----
 arch/arm/boot/dts/tegra-harmony.dts   |  100 +++++------
 arch/arm/boot/dts/tegra-paz00.dts     |  112 ++++++-------
 arch/arm/boot/dts/tegra-seaboard.dts  |  176 +++++++++----------
 arch/arm/boot/dts/tegra-trimslice.dts |   71 ++++-----
 arch/arm/boot/dts/tegra-ventana.dts   |   90 +++++------
 arch/arm/boot/dts/tegra20.dtsi        |  277 ++++++++++++++++--------------
 arch/arm/boot/dts/tegra30.dtsi        |  304 ++++++++++++++++++---------------
 8 files changed, 577 insertions(+), 615 deletions(-)

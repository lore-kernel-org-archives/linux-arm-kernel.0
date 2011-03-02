From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Mar 2011 18:34:46 +0100
Subject: [PATCH/RFC 0/3] ARM: S5P: Add common DPHY control code for
	MIPI-CSIS/MIPI-DSIM devices
Message-ID: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch series adds a common platform code to enable control 
of MIPI-CSI receiver's DPHY from within it's V4L2 subdev driver. The driver
is supposed to support possibly all S5P SoCs variants and the PHY handling
details need to be hidden in the platform code. The functionality behind
"dphy_csis" clocks is not exact a functionality of the clock, but they have 
common features. If the clock API rules are to strict to accept this kind 
of usage then I'm willing to create some intermediate layer that will finally
solve PHY handling for MIPI-CSI, MIPI-DSIM, USB, SATA.. devices, without issues
on a common kernel binary for multiple boards.


The patch series contains:
[PATCH 1/3] ARM: S5P: Rename MIPI-CSIS header and update Copyright
[PATCH 2/3] ARM: S5PV210: Add clock entries for MIPI DPHY control
[PATCH 3/3] ARM: EXYNOS4: Add clock entries for MIPI DPHY control

Rebased onto kgene-for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 


Regards,
--
Sylwester Nawrocki
Samsung Poland R&D Center

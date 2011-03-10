From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Mar 2011 12:06:32 +0100
Subject: [PATCH v3 0/3] ARM: S5P: Add platform helpers for MIPI-CSIS/DSIM DPHY
In-Reply-To: <002601cbdead$0f1cb840$2d5628c0$%kim@samsung.com>
References: <002601cbdead$0f1cb840$2d5628c0$%kim@samsung.com>
Message-ID: <1299755195-9055-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following is a third version of a change set adding platform helpers 
for the MIPI-CSIS and MIPI-DSIM PHYs control on S5PV210 and Exynos4.

Changes since v2:
 - renamed setup-mipi.c/setup-mipidphy.c
 - regs-pmu.h header included in regs-clock.s in mach-exynos4 to get
   rid of CONFIG_ARCH_EXYNOS4 in setup-mipiphy.c

Changes since v1:
 - updated the platform data structure with an additional flag indicating
   whether the driver should attempt to control the external mipi-csis 
   (VDD18_MIPI) voltage regulator or not. This might be needed on systems 
   where MIPI VDD power supply cannot be separately switched on/off.


The patch series contains:
 [PATCH v3 1/3] ARM: S5P: Rename MIPI-CSIS driver header and update Copyright
 [PATCH v3 2/3] ARM: S5P: Extend MIPI-CSIS platform_data with the PHY control callback
 [PATCH v3 3/3] ARM: S5P: Add support for common MIPI CSIS/DSIM D-PHY control

Created against for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 

Regards,
--
Sylwester Nawrocki
Samsung Poland R&D Center

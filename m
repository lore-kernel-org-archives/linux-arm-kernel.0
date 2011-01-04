From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 04 Jan 2011 16:09:21 +0100
Subject: [PATCH/RFC 0/3] ARM: S5P: Add a common platform setup code for MIPI
	CSIS/DSIM
Message-ID: <1294153764-25006-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch series adds the common platform code for configuration 
of the MIPI CSIS and MIPI DSIM PHYs on S5PV210 and S5PV310 SoCs.
The spinlock is used to avoid races while the common PHY control register
is accessed from within MIPI DSIM and MIPI CSIS drivers.
The common PHY enable bit is cleared only when both CSIS and DSIM devices
are not in use.


The patch series contains:

[PATCH/RFC 1/3] ARM: S5P: Add a platform callback for MIPI CSIS PHY control
[PATCH/RFC 2/3] ARM: S5PV310: Add a platform helper for MIPI DSIM/CSIS setup
[PATCH/RFC 3/3] ARM: S5PV210: Add a platform helper for MIPI DSIM/CSIS setup

Rebased onto kgene-for-next branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 


Regards,
Sylwester


--
Sylwester Nawrocki
Samsung Poland R&D Center

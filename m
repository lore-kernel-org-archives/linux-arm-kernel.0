From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Mar 2013 12:41:52 -0400 (EDT)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
Message-ID: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell, would you please pull the following:

	git://git.linaro.org/people/nico/linux mcpm

This contains the basic infrastructure needed to support CPU hotplug, 
deep CPU idle and secondary CPU bringup in a cluster based system such 
as, but not limited to, those based on the big.LITTLE architecture.

This is the same set of patches from the previous pull request that 
missed thelast merge window, except for minor changes needed for this 
code to work with v3.9-rc3 (i.e. removal of the __cpuinit tags and 
removal of set_smp_cross_call() from the smp_init_cpus method).

The diffstat follows:

 Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
 Documentation/arm/vlocks.txt                    | 211 ++++++++
 arch/arm/Kconfig                                |   8 +
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/mcpm_entry.c                    | 314 +++++++++++
 arch/arm/common/mcpm_head.S                     | 219 ++++++++
 arch/arm/common/mcpm_platsmp.c                  |  87 +++
 arch/arm/common/vlock.S                         | 108 ++++
 arch/arm/common/vlock.h                         |  29 +
 arch/arm/include/asm/mcpm_entry.h               | 190 +++++++
 10 files changed, 1665 insertions(+)


Nicolas

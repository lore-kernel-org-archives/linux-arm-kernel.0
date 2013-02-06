From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Feb 2013 14:12:27 -0500 (EST)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
Message-ID: <alpine.LFD.2.02.1302061343360.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, would you please pull the following:

	git://git.linaro.org/people/nico/linux mcpm

This contains the basic infrastructure needed to support CPU hotplug, 
deep CPU idle and secondary CPU bringup in a cluster based system such 
as, but not limited to, those based on the big.LITTLE architecture.

Several rounds of reviews took place on the list and all comments were 
addressed.

Included is the core infrastructure only.  That already represents a 
significant chunk of code on its own.  I'm hoping to be able to send a 
second pull request containing platform support for RTSM if the CCI 
device tree bindings get sorted out in time.  Platform support for TC2 
does exist but more cleanups are needed there which are very unlikely to 
make it in time for the 3.9 merge window.

Here's the diffstat for this pull request:
 Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
 Documentation/arm/vlocks.txt                    | 211 ++++++++
 arch/arm/Kconfig                                |   8 +
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/mcpm_entry.c                    | 314 +++++++++++
 arch/arm/common/mcpm_head.S                     | 219 ++++++++
 arch/arm/common/mcpm_platsmp.c                  |  86 +++
 arch/arm/common/vlock.S                         | 108 ++++
 arch/arm/common/vlock.h                         |  29 +
 arch/arm/include/asm/mcpm_entry.h               | 190 +++++++
 10 files changed, 1664 insertions(+)


Nicolas

From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:55 +0200
Subject: [GIT PULL] ARM: actions: arm+sps for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <20170623172556.12618-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is a second arm pull for Actions Semi, merging the SPS driver so that it
can be reused in mach-actions SMP code for CPU bring-up.

Regards,
Andreas

The following changes since commit ba2694def2361d9b8d944f6df4aa077ad7290746:

  MAINTAINERS: Update Actions Semi section with SPS (2017-06-21 18:17:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git actions-arm-soc+sps-for-4.13

for you to fetch changes up to b6a0e18ca690c2398661c42b942187621ab77e36:

  ARM: owl: smp: Implement SPS power-gating for CPU2 and CPU3 (2017-06-23 18:01:35 +0200)

----------------------------------------------------------------
Actions Semi ARM SoC for v4.13 #2

This adds SMP code to bring up the remaining S500 CPU cores
by reusing a helper factored out of the SPS power domains driver.

----------------------------------------------------------------
Andreas F?rber (5):
      dt-bindings: power: Add Owl SPS power domains
      soc: actions: Add Owl SPS
      soc: actions: owl-sps: Factor out owl_sps_set_pg() for power-gating
      Merge branch 'v4.13/sps' into v4.13/arm+sps
      ARM: owl: smp: Implement SPS power-gating for CPU2 and CPU3

 .../devicetree/bindings/power/actions,owl-sps.txt  |  17 ++
 arch/arm/mach-actions/Kconfig                      |   1 +
 arch/arm/mach-actions/platsmp.c                    |  36 +++-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/actions/Kconfig                        |  16 ++
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |  51 +++++
 drivers/soc/actions/owl-sps.c                      | 224 +++++++++++++++++++++
 include/dt-bindings/power/owl-s500-powergate.h     |  19 ++
 include/linux/soc/actions/owl-sps.h                |  11 +
 11 files changed, 377 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 drivers/soc/actions/Kconfig
 create mode 100644 drivers/soc/actions/Makefile
 create mode 100644 drivers/soc/actions/owl-sps-helper.c
 create mode 100644 drivers/soc/actions/owl-sps.c
 create mode 100644 include/dt-bindings/power/owl-s500-powergate.h
 create mode 100644 include/linux/soc/actions/owl-sps.h

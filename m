From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 05 Aug 2015 11:22:51 +0100
Subject: [GIT PULL] ARM64: juno: SCPI and dependent drivers for v4.3
Message-ID: <55C1E3FB.5090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


Here is the first pull request for SCPI, clock and cpufreq support on
ARM64 Juno development platform for v4.3

Regards,
Sudeep

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

    Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

    git://linux-arm.org/linux-skn.git juno_dvfs

for you to fetch changes up to a42b1bbf7bf9a2a1fa4b0deff66581b83541b819:

    arm64: dts: add clock support for all the cpus (2015-08-05 11:03:09 
+0100)

----------------------------------------------------------------
Sudeep Holla (8):
        Documentation: add DT binding for ARM System Control and Power 
Interface(SCPI) protocol
        firmware: add support for ARM System Control and Power 
Interface(SCPI) protocol
        clk: add support for clocks provided by SCP(System Control 
Processor)
        clk: scpi: add support for cpufreq virtual device
        cpufreq: arm_big_little: add SCPI interface driver
        arm64: dts: add SRAM, MHU mailbox and SCPI support on Juno
        arm64: dts: add CPU topology on Juno
        arm64: dts: add clock support for all the cpus

   Documentation/devicetree/bindings/arm/arm,scpi.txt | 150 +++
   MAINTAINERS                                        |  10 +
   arch/arm64/boot/dts/arm/juno-base.dtsi             |  54 ++
   arch/arm64/boot/dts/arm/juno-r1.dts                |  32 +
   arch/arm64/boot/dts/arm/juno.dts                   |  32 +
   drivers/clk/Kconfig                                |  10 +
   drivers/clk/Makefile                               |   1 +
   drivers/clk/clk-scpi.c                             | 325 +++++++
   drivers/cpufreq/Kconfig.arm                        |   9 +
   drivers/cpufreq/Makefile                           |   1 +
   drivers/cpufreq/scpi-cpufreq.c                     | 124 +++
   drivers/firmware/Kconfig                           |  19 +
   drivers/firmware/Makefile                          |   1 +
   drivers/firmware/arm_scpi.c                        | 711 +++++++++++++
   include/linux/scpi_protocol.h                      |  61 ++
   15 files changed, 1540 insertions(+)
   create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
   create mode 100644 drivers/clk/clk-scpi.c
   create mode 100644 drivers/cpufreq/scpi-cpufreq.c
   create mode 100644 drivers/firmware/arm_scpi.c
   create mode 100644 include/linux/scpi_protocol.h

From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:27:25 +0900
Subject: [PATCH 00/08] ARM: shmobile: EMEV2 and KZM9D update
Message-ID: <20130702092725.32066.54861.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: EMEV2 and KZM9D update

[PATCH 01/08] ARM: shmobile: Remove unused EMEV2/KZM9D early console
[PATCH 02/08] ARM: shmobile: Update KZM9D dts command line
[PATCH 03/08] ARM: shmobile: Make EMEV2 platform devices more compact
[PATCH 04/08] ARM: shmobile: Add GIO to EMEV2 dtsi
[PATCH 05/08] ARM: shmobile: Use DT for GIC on EMEV2 and KZM9D
[PATCH 06/08] ARM: shmobile: Use DT for SMP on EMEV2 and KZM9D
[PATCH 07/08] ARM: shmobile: EMEV2 map_io update
[PATCH 08/08] ARM: shmobile: Disconnect EMEV2 SMP code from clocks

Several minor updates for the EMEV2 SoC and the KZM9D board:
- Get rid of early console - the 8250-em driver does not support it
- Update command line in DTS and remove old cruft
- Make the EMEV2 platform devices more compact
- Add GIO device nodes to the EMEV2 dtsi
- Use DT for GIC and SMP for both regular KZM9D board code and DT
- Reduce the size of the EMEV2 map_io - SCU is still however needed
- Allow EMEV2 SMP to operate without legacy clock bits

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130702

 arch/arm/boot/dts/emev2-kzm9d.dts           |    2 
 arch/arm/boot/dts/emev2.dtsi                |   59 ++++
 arch/arm/mach-shmobile/board-kzm9d.c        |    4 
 arch/arm/mach-shmobile/clock-emev2.c        |   18 -
 arch/arm/mach-shmobile/include/mach/emev2.h |    4 
 arch/arm/mach-shmobile/setup-emev2.c        |  374 ++++-----------------------
 arch/arm/mach-shmobile/smp-emev2.c          |   28 --
 7 files changed, 142 insertions(+), 347 deletions(-)

From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:51:52 +0900
Subject: [PATCH 00/05] ARM: shmobile: r8a73a4 SMP and CPU Hotplug prototype v2
Message-ID: <20130530085152.24374.64208.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a73a4 SMP and CPU Hotplug prototype v2

[PATCH 01/05] ARM: shmobile: r8a73a4 SMP prototype v1 (CA15 x 4)
[PATCH 02/05] ARM: shmobile: r8a73a4 CPU Hotplug prototype v1 (CA15 x 4)
[PATCH 03/05] ARM: shmobile: r8a73a4 CA15 setup WFE as NOP
[PATCH 04/05] ARM: shmobile: r8a73a4 SMP CA7 prototype (+ CA7 x 4)
[PATCH 05/05] ARM: shmobile: r8a73a4 CA7 setup arch timer

Here's V2 of r8a73a4 SMP prototype support. This time support for
both CA15 and CA7 is included.

It is worth noting that only prototype support for the actual SoC
is included here. It is included as SMP support, but since CA7 cores
perform differently compared to CA15 the system will not behave in a
deterministic way unless either big.LITTLE MP patches are used to
extend the scheduler or c-groups are used to separate CA15 and CA7.

All 8 cores boot up as expected but certainly needs more work.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against linux.git 7b55eab81ecbbd44e76ac14c67479b82807c261b
 
 arch/arm/boot/dts/r8a73a4.dtsi                |   49 ++++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/board-ape6evm.c        |    1 
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    1 
 arch/arm/mach-shmobile/smp-r8a73a4.c          |  274 ++++++++++++++++++++++++-
 6 files changed, 321 insertions(+), 6 deletions(-)

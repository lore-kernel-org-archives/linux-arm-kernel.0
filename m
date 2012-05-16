From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 16 May 2012 15:44:49 +0900
Subject: [PATCH 00/08] mach-shmobile: Emma Mobile EV2 support V3
Message-ID: <20120516064449.32286.77941.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-shmobile: Emma Mobile EV2 support V3

[PATCH 01/08] mach-shmobile: Emma Mobile EV2 SoC base support V3
[PATCH 02/08] ARM: Undelete KZM9D mach-type V3
[PATCH 03/08] mach-shmobile: KZM9D board support V3
[PATCH 04/08] mach-shmobile: Emma Mobile EV2 SMP support V3
[PATCH 05/08] mach-shmobile: Emma Mobile EV2 GPIO support V3
[PATCH 06/08] mach-shmobile: KZM9D board Ethernet support V3
[PATCH 07/08] mach-shmobile: Emma Mobile EV2 DT support V3
[PATCH 08/08] mach-shmobile: Use DT_MACHINE for KZM9D V3

This series are the third iteration of Emma Mobile EV2 support
for mach-shmobile. Yet another dual core Cortex-A9 SoC.

At this point serial, timer and gpio are supported as platform
devices. Serial and timer also come with DT bindings.

Basic SMP support is in place, but CPU hotplug and TWD needs
more work.

Clocks are enabled in the case of the KZM9D board support
via platform devices. In the DT case there are no clocks
enabled. So anyone playing around with DT will have to accept
the fact that it is very limited at tis point. All features with
upstream support can however be enabled via regular platform devices.

Many thanks to Arnd for his endless reviews and helpful
suggestions and a lot of patience!

To build this you also need whatever included in linux-next
as of 20120514 plus the following patches:

[PATCH 01/03] clockevents: Make clockevents_config() a global symbol
[PATCH 02/03] clocksource: em_sti: Emma Mobile STI driver V2
[PATCH 03/03] clocksource: em_sti: Add DT support
[PATCH] gpio: Emma Mobile GPIO driver V2

The only update since V2 of this series is DT related bits
in [7/8] and [8/8] plus the mach-type change in [2/8].

In case the GPIO driver does not get merged it should be possible
to omit [5/8] and [6/8] and still have a working but limited system.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to linux-next 20120514

 arch/arm/boot/dts/emev2-kzm9d.dts           |   26 +
 arch/arm/boot/dts/emev2.dtsi                |   63 +++
 arch/arm/mach-shmobile/Kconfig              |   11 
 arch/arm/mach-shmobile/Makefile             |    3 
 arch/arm/mach-shmobile/board-kzm9d.c        |   89 +++++
 arch/arm/mach-shmobile/clock-emev2.c        |  249 ++++++++++++++
 arch/arm/mach-shmobile/include/mach/emev2.h |   19 +
 arch/arm/mach-shmobile/platsmp.c            |   20 +
 arch/arm/mach-shmobile/setup-emev2.c        |  454 ++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/smp-emev2.c          |   97 +++++
 arch/arm/tools/mach-types                   |    1 
 11 files changed, 1028 insertions(+), 4 deletions(-)

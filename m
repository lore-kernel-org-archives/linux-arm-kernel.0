From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed,  9 Jul 2014 15:12:36 +0200
Subject: [PATCH v5 0/8] Enable timers DT devices for Marzen, Genmai,
 Lager and Koelsch
Message-ID: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set enables timer devices in DT for the Marzen, Genmai, Lager and
Koelsch boards. It has previously been posted as part of the "[PATCH v4 00/19]
Renesas CMT, MTU2 and TMU timers DT support" series, and is now split into its
own patch set for merge in v3.17.

The series depends on the driver changes of the "[PATCH v4 00/19] Renesas CMT,
MTU2 and TMU timers DT support" series, for which a pull request has been sent.

Changes since v4:

- Rebased on top of Simon's latest devel branch
- Dropped driver patches merged through the clocksource tree

Changes since v3:

- Fixed TMU interrupt numbers
- Fixed NULL platform device ID dereference in TMU driver
- Removed interrupt-parent property from documentation
- Add missing of_match_ptr() and __maybe_unused() annotations

Changes since v2:

- Rebased on top of Simon's latest devel branch

Changes since v1:

- Dropped the channel subnodes from the CMT DT bindings and just use a
  channels mask, as we don't need to specify per-channel properties.

Laurent Pinchart (8):
  ARM: shmobile: r8a7790: Add CMT devices to DT
  ARM: shmobile: r8a7791: Add CMT devices to DT
  ARM: shmobile: r8a7779: Add TMU devices to DT
  ARM: shmobile: r7s72100: Add MTU2 device to DT
  ARM: shmobile: lager-reference: Enable CMT0 in device tree
  ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
  ARM: shmobile: marzen-reference: Enable TMU0 in device tree
  ARM: shmobile: genmai-reference: Enable MTU2 in device tree

 arch/arm/boot/dts/r7s72100-genmai.dts            |  4 +++
 arch/arm/boot/dts/r7s72100.dtsi                  | 10 ++++++
 arch/arm/boot/dts/r8a7779-marzen.dts             |  4 +++
 arch/arm/boot/dts/r8a7779.dtsi                   | 42 ++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts              |  4 +++
 arch/arm/boot/dts/r8a7790.dtsi                   | 32 ++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  4 +++
 arch/arm/boot/dts/r8a7791.dtsi                   | 32 ++++++++++++++++++
 arch/arm/mach-shmobile/board-genmai-reference.c  | 20 -----------
 arch/arm/mach-shmobile/board-genmai.c            | 14 +++++++-
 arch/arm/mach-shmobile/board-koelsch-reference.c |  2 --
 arch/arm/mach-shmobile/board-lager-reference.c   |  2 --
 arch/arm/mach-shmobile/board-marzen-reference.c  | 10 ------
 arch/arm/mach-shmobile/r7s72100.h                |  1 -
 arch/arm/mach-shmobile/r8a7779.h                 |  1 -
 arch/arm/mach-shmobile/r8a7790.h                 |  1 -
 arch/arm/mach-shmobile/r8a7791.h                 |  1 -
 arch/arm/mach-shmobile/setup-r7s72100.c          | 21 ------------
 arch/arm/mach-shmobile/setup-r8a7779.c           | 17 +++-------
 arch/arm/mach-shmobile/setup-r8a7790.c           |  7 +---
 arch/arm/mach-shmobile/setup-r8a7791.c           |  7 +---
 21 files changed, 152 insertions(+), 84 deletions(-)

-- 
Regards,

Laurent Pinchart

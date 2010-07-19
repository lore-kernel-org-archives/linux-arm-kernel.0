From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 17:30:32 +0900
Subject: [PATCH 0/4] ARM: S5PV210: Clock Framework: powerdomain, block-gating,
	flags
Message-ID: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add support for powerdomain, block-gating, and flags in struct clk.

Blockgating re-uses powerdomain support scheme and depends on powerdomain support.

Flags support is independent from powerdomain; however, powerdomain support is NOT stable without flags support. Without flags support, powerdomain may lock up the system with some conditions although they are rare. Thus, when powerdomain or block-gating is used, flags support should be turned on for the system stability. (and that's why I'm sending flags support with powerdomain/block-gating support).

Although powerdomain support is requred for blockgating, blockgating is NOT required for powerdomain. Besides, powerdomain support is observed to reduce power consumption significantly (with 2.6.29 kernel); however, blockgating support didn't show any significant improvement.


MyungJoo Ham (4):
  ARM: SAMSUNG SoC: Powerdomain/Block-gating Support
  ARM: S5PV210: Powerdomain/Clock-gating Support
  ARM: SAMSUNG SoC: Clock Framework: Flag Support for struct clk.
  ARM: S5PV210: Clock Framework: Flag Support for struct clk.

 arch/arm/mach-s5pv210/Kconfig              |   17 +
 arch/arm/mach-s5pv210/clock.c              |  906 ++++++++++++++++++++++------
 arch/arm/plat-samsung/Kconfig              |   19 +
 arch/arm/plat-samsung/clock.c              |  146 +++++-
 arch/arm/plat-samsung/include/plat/clock.h |   44 ++
 5 files changed, 935 insertions(+), 197 deletions(-)

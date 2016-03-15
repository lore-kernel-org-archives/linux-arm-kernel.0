From: dawei.chien@mediatek.com (Dawei Chien)
Date: Tue, 15 Mar 2016 16:10:34 +0800
Subject: [RESEND][PATCH v6 0/3] thermal: mediatek: Add cpu dynamic power
 cooling model.
Message-ID: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Intelligent Power Allocation (IPA) technical to add dynamic power model for binding CPU thermal zone. The power allocator governor allocates power budget to control CPU temperature.

Power Allocator governor is able to keep SOC temperature within a defined temperature range to avoid SOC overheat and keep it's performance.
mt8173-cpufreq.c need to register its' own power model with power allocator thermal governor, so that power allocator governor can allocates suitable power budget to control CPU temperature.

Binding document is refer to this patchset
https://lkml.org/lkml/2015/11/30/239

Change since V5:
1. Remove thermal sensor ID from phandles

Change since V4:
1. Remove unnecessary error-checking for mt8173-cpufreq.c 2. Initializing variable capacitance with 0

Change since V3:
1. Remove static power model
2. Split V3's device tree in two for thermal zones and dynamic power models respectively

Change since V2:
1. Move dynamic/static power model in device tree

Change since V1:
1. Include mt8171.h and sort header file for mt8173.dtsi

Dawei Chien (3):
  thermal: mediatek: Add cpu dynamic power cooling model.
  arm64: dts: mt8173: Add thermal zone node.
  arm64: dts: mt8173: Add dynamic power node.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   47 ++++++++++++++++++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   12 ++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

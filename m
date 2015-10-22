From: dawei.chien@mediatek.com (Dawei Chien)
Date: Thu, 22 Oct 2015 20:02:37 +0800
Subject: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Message-ID: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use Intelligent Power Allocation (IPA) technical to add static/dynamic power model for binding CPU thermal zone.
The power allocator governor allocates power budget to control CPU temperature.

Power Allocator governor is able to keep SOC temperature within a defined temperature range to avoid SOC overheat and keep it's performance. mt8173-cpufreq.c need to register its' own power model with power allocator thermal governor, so that power allocator governor can allocates suitable power budget to control CPU temperature.

PATCH1 is base on
https://patchwork.kernel.org/patch/7034601/

PATCH2 is base on Sascha's thermal driver V9
https://patchwork.kernel.org/patch/7249821/
https://patchwork.kernel.org/patch/7249861/
https://patchwork.kernel.org/patch/7249891/

Change since V1:
include mt8171.h and sort header file for mt8173.dtsi

Change since V2:
Move dynamic/static power model in device tree

Dawei.Chien (2):
  thermal: mediatek: Add cpu power cooling model.
  arm64: dts: mt8173: Add thermal zone node for mt8173.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++
 drivers/cpufreq/mt8173-cpufreq.c         |   97 ++++++++++++++++++++++++++----
 2 files changed, 130 insertions(+), 11 deletions(-)

--
1.7.9.5

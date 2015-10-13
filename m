From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 08:58:12 +0800
Subject: [PATCH v2 0/4] arm64: Hi6220: enable CPU idle states
Message-ID: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to enable CPU idle states for Hi6220.

Hi6220 uses PSCIv0.2 compliance interface, so directly use ARM's generic
CPUIdle driver. Patch 1 is to reserve memory regions so make sure MCU can
work well to handle power controlling; Patch 2/3 enable sp804 timer as
broadcast timer during idle states; Patch 4 registers CPU power down state
and cluster power down state.

Changes from v1:
* According to Sudeep's review, fix binding for idle-states
* According to Rob's review, due timers share same clock source with apb
  clock, so just only pass one clock phandle


Leo Yan (4):
  arm64: dts: Reserve memory regions for hi6220
  arm64: Kconfig: select sp804 timer for ARCH_HISI
  arm64: dts: add sp804 timer node for Hi6220
  arm64: dts: enable idle states for Hi6220

 arch/arm64/Kconfig.platforms                   |  1 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 16 ++++++++---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 40 ++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

-- 
1.9.1

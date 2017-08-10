From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 10 Aug 2017 10:26:06 +0800
Subject: [PATCH v2 0/9] arm64: dts: hi3660: add more device nodes
Message-ID: <20170810022615.19204-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds more device nodes for hi3660 and hikey960, including:
 - cpu idle states
 - L2 cache
 - PMU
 - OP-TEE
 - reboot
 - pstore
 - DMA

Patch 7 fixes an issue in mmc nodes, by adding 'reset'
Patch 8 change bluetooth uart max-speed to 3Mbps

HiKey960 is one of 96boards. For details information about it, please
refer to [1].

===
Major changes in v2:
 - add patch 8 to change bluetooth uart max-speed to 3Mbps
 - add patch 9 for DMA node.

[1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960

Guodong Xu (4):
  arm64: dts: hikey960: Add support for syscon-reboot-mode
  arm64: dts: hikey960: Add pstore support
  arm64: dts: hi3660: Reset the mmc hosts
  arm64: dts: hikey960: change bluetooth uart max-speed to 3mbps

Leo Yan (2):
  arm64: dts: hi3660: enable idle states
  arm64: dts: hi3660: add L2 cache topology

Victor Chong (1):
  arm64: dts: hikey960: Add optee node

Wang Ruyi (1):
  arm64: dts: hi3660: add bindings for DMA

YiPing Xu (1):
  arm64: dts: hi3660: add pmu dt node for hi3660

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  37 ++++++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 114 ++++++++++++++++++++++
 2 files changed, 150 insertions(+), 1 deletion(-)

-- 
2.10.2

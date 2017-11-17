From: xuyiping@hisilicon.com (Xu YiPing)
Date: Fri, 17 Nov 2017 17:27:29 +0800
Subject: [PATCH v3 0/3] Add support for Hi3660 stub clock
Message-ID: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Hi3660 has stub clocks for two CPU clusters, GPU and DDR; and the stub
clocks use the mailbox to send message to MCU for frequency scaling.

This patch set adds support Hi3660 stub clock, and since it needs to
use mailbox so this patch set has dependency with Hi3660 mailbox
patch set [1].

This patch set has been tested on Hikey960 with CPUFreq enabled.

Changes from v1:
* According to Rob suggestion, moved dt header definition into DT patch;
* According to Julien suggestion, removed "dev" member from stub clock
  structure and refined code for global variable "stub_clk_chan";
* Fixed DT binding patch.

[1] http://archive.armlinux.org.uk/lurker/message/20171027.061501.f895dee8.en.html


Kaihua Zhong (2):
  clk: hisilicon: Add support for Hi3660 stub clocks
  arm64: dts: Hi3660: Add binding for stub clock

Leo Yan (1):
  dt-bindings: clk: Hi3660: Document stub clock

 .../devicetree/bindings/clock/hi3660-clock.txt     |   6 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   7 +
 drivers/clk/hisilicon/Kconfig                      |   6 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3660-stub.c            | 186 +++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h           |   7 +
 6 files changed, 213 insertions(+)
 create mode 100644 drivers/clk/hisilicon/clk-hi3660-stub.c

-- 
1.9.1

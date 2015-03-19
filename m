From: kong.kongxinwei@hisilicon.com (kongxinwei)
Date: Thu, 19 Mar 2015 15:57:26 +0800
Subject: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Message-ID: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linaro connect introduce 96boards series in Hong Kong,The HiKey board
is the first board to be certified 96Boards Consumer Edition compatible.
This board is based on the HiSilicon SoC. you can get more information
from https://www.96boards.org.

The hisilicon SoC contains thermal module, this thermal module has 4 sensors,

	- sensor 0: local sensor;
	- sensor 1: remote sensor for ACPU cluster 1;
	- sensor 2: remote sensor for ACPU cluster 2;
	- sensor 3: remote sensor for GPU;

It can obtain this device temperature by operating this hardware. The new
sensor driver satisfies thermal framework and to realize the ACPU ,GPU and
so on to cool function.

kongxinwei (3):
  thermal: hisilicon: add new hisilicon thermal sensor driver
  dts: hi6220: enable thermal sensor for hisilicon SoC
  dt-bindings: Document the hi6220 thermal sensor bindings

 .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
 drivers/thermal/Kconfig                            |   8 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/hisi_thermal.c                     | 531 +++++++++++++++++++++
 5 files changed, 744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 drivers/thermal/hisi_thermal.c

-- 
1.9.1

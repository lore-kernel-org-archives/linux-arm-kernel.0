From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:03:57 +0800
Subject: [PATCH v4 00/20] arm64: dts: hi3660: add device nodes
Message-ID: <20170615030417.14059-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds various devices nodes for hi3660 and hikey960.

HiKey960 is one of 96boards. For details information about it, please
refer to [1].

In v4, I removed cpuidle patch
* (v3-0014-arm64-dts-hi3660-enable-idle-states.patch)
  , since we are not sure yet whether the corresponding driver can get
  into mainline. Sorry about the noise.
* Other patches are not changed.

In v3,
* nothing is changed for patches already exists in v2.
* added 9 more dts patches. Most of them already were reviewed with their
    corresponding driver patchset. For purpose of easy integration for
    platform maintainer, I copied them here, including threads [2], [3],
    and [4].
* four patches, this is the first time they are sent out for review.
v3-0014-arm64-dts-hi3660-enable-idle-states.patch
v3-0019-dt-bindings-mmc-dw_mmc-k3-add-document-of-hi3660-.patch
v3-0020-arm64-dts-hi3660-add-sd-sdio-device-nodes.patch
v3-0021-arm64-dts-hi3660-hikey960-add-nodes-for-WiFi.patch
    mmc driver is under review in [5].

In v2, incorporated review comments from Rob Herring <robh@kernel.org>
* uart4: max-speed should be in slave device bluetooth node
* LEDs:	- bt_active triggered by 'hci0-power'
	- move out of SoC level
* pinctrl: update dts to use #pinctrl-cells
* uart: add pinctrl information into uart nodes; add label strings.
* chosen: update stdout-path. serial6 is used.
* i2c: add label strings. change reg address to lower case.
* remove unnecessary status="ok"
* gpio-keys: move out of SoC level.

[1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960
[2] sp804 timer: https://www.spinics.net/lists/kernel/msg2513025.html
[3] PCIe: https://www.spinics.net/lists/kernel/msg2520677.html
[4] mfd and regulator: https://www.spinics.net/lists/arm-kernel/msg586147.html
[5] mmc: https://patchwork.kernel.org/patch/9783273/

Chen Feng (2):
  arm64: dts: hi3660: Add uarts nodes
  arm64: dts: hi3660: Add pl031 rtc node

Chen Jun (1):
  arm64: dts: hi3660: add power key dts node

Guodong Xu (7):
  dt-bindings: arm: hisilicon: add bindings for HiKey960 board
  arm64: dts: hisilicon: update compatible string for hikey960
  arm64: dts: hikey960: add WL1837 Bluetooth device node
  arm64: dts: hikey960: add LED nodes
  dt-bindings: mfd: hi6421: Add hi6421v530 compatible string
  dt-bindings: mmc: dw_mmc-k3: add document of hi3660 mmc
  arm64: dts: hi3660-hikey960: add nodes for WiFi

Leo Yan (1):
  arm64: dts: hi3660: add sp804 timer node

Li Wei (1):
  arm64: dts: hi3660: add sd/sdio device nodes

Wang Xiaoyin (4):
  arm64: dts: hikey960: pinctrl: add more pinmux and pinconfig
  arm64: dts: hi3660: add gpio dtsi file for Hisilicon Hi3660 SOC
  arm64: dts: hi3660: add spi device nodes
  arm64: dts: hikey960: add device node for pmic and regulators

Xiaowei Song (2):
  dt-bindings: PCI: hisi: Add document for PCIe of Kirin SoCs
  arm64: dts: hisi: add kirin pcie node

Zhangfei Gao (2):
  arm64: dts: hi3660: add resources for clock and reset
  arm64: dts: Add I2C nodes for Hi3660

 .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
 Documentation/devicetree/bindings/mfd/hi6421.txt   |   4 +-
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   1 +
 .../devicetree/bindings/pci/kirin-pcie.txt         |  50 ++
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  | 217 +++++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 702 ++++++++++++++++++-
 .../arm64/boot/dts/hisilicon/hikey960-pinctrl.dtsi | 778 +++++++++++++++++++--
 7 files changed, 1681 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

-- 
2.10.2

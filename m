From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 20 May 2018 10:47:31 +0530
Subject: [PATCH v2 0/5] Add gpio support for Action Semi S900 SoC
Message-ID: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds gpio support for Actions Semi S900 SoC by extending
the pinctrl driver. There were previous patches submitted for adding a
standalone gpio driver based on gpiolib. But later on it has been realised
that the gpio functionality is closely tied with pinctrl subsystem for this
OWL family processors. So, having a separate gpio driver will make it hard
to add further functionalities in future. Hence, we decided to drop the
previous patches below adding a standalone gpio support:

dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
arm64: dts: actions: Add S900 gpio nodes
arm64: dts: actions: Add gpio line names to Bubblegum-96 board
gpio: Add gpio driver for Actions OWL S900 SoC
MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries

This patchset consits of incremental patches which will apply with the
previous pinctrl series: Add Actions Semi S900 pinctrl and gpio support,
excluding the dropped patches mentioned above.

Thanks,
Mani

Changes in v2:

* Removed gpiochip_add_pin_range() function and added gpio-ranges property
  in DT.
* Added Reviewed-by tag from Andy.

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
  arm64: dts: actions: Add gpio properties to pinctrl node for S900
  arm64: dts: actions: Add gpio line names to Bubblegum-96 board
  pinctrl: actions: Add gpio support for Actions S900 SoC
  MAINTAINERS: Add Actions Semi S900 pinctrl entries

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  16 ++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  | 175 ++++++++++++++++++
 arch/arm64/boot/dts/actions/s900.dtsi              |   3 +
 drivers/pinctrl/actions/Kconfig                    |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c              | 198 +++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  20 +++
 drivers/pinctrl/actions/pinctrl-s900.c             |  29 ++-
 8 files changed, 443 insertions(+), 1 deletion(-)

-- 
2.14.1

From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Jul 2018 17:06:22 +0200
Subject: [GIT PULL] Reset controller changes for v4.19
Message-ID: <1532099182.3438.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

? Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

? git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.19

for you to fetch changes up to 6b39fd590aebca1a6a4c827f29f14d2b6df3939d:

? reset: uniphier: add reset control support for SPI (2018-07-19 11:19:47 +0200)

----------------------------------------------------------------
Reset controller changes for v4.19

This adds new drivers and bindings for the SDM845 AOSS (always on
subsystem) reset controller and for the Uniphier USB3 core reset.
SPI controller resets are added to the Uniphier reset driver.

----------------------------------------------------------------
Kunihiko Hayashi (4):
??????reset: simple: export reset_simple_ops to be referred from modules
??????dt-bindings: reset: uniphier: add USB3 core reset support
??????reset: uniphier: add USB3 core reset control
??????reset: uniphier: add reset control support for SPI

Sibi Sankar (2):
??????dt-bindings: reset: Add AOSS reset bindings for SDM845 SoCs
??????reset: qcom: AOSS (always on subsystem) reset controller

?.../devicetree/bindings/reset/qcom,aoss-reset.txt??|??52 +++++++
?.../devicetree/bindings/reset/uniphier-reset.txt???|??56 +++++++
?drivers/reset/Kconfig??????????????????????????????|??19 +++
?drivers/reset/Makefile?????????????????????????????|???2 +
?drivers/reset/reset-qcom-aoss.c????????????????????| 133 ++++++++++++++++
?drivers/reset/reset-simple.c???????????????????????|???1 +
?drivers/reset/reset-uniphier-usb3.c????????????????| 171 +++++++++++++++++++++
?drivers/reset/reset-uniphier.c?????????????????????|???9 ++
?include/dt-bindings/reset/qcom,sdm845-aoss.h???????|??17 ++
?9 files changed, 460 insertions(+)
?create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
?create mode 100644 drivers/reset/reset-qcom-aoss.c
?create mode 100644 drivers/reset/reset-uniphier-usb3.c
?create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h

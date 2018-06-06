From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 6 Jun 2018 22:49:17 +0530
Subject: [GIT PULL] Mailbox changes for v4.18
Message-ID: <CABb+yY2MLfH4a+AKQfQw6fm2_Ej7F-m64RJTBb813o=_R5cxuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 7fbb6157630f2ba6ee355689061f9596b84373ef:

  Merge tag 'armsoc-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-05-26
14:05:16 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.18

for you to fetch changes up to f83d1cfc8bcddf93bb6f55940fd59f5b047863e5:

  mailbox/drivers/hisi: Consolidate the Kconfig for the MAILBOX
(2018-06-06 22:21:59 +0530)

----------------------------------------------------------------
- Remove HAS_DMA config dependencies
- New STMicroelectronics STM32 IPCC driver
- Enable QCom driver to run more controllers
- Fixed return code from null to ptr-err for Brcm driver
- Fix kconfig dependencies for the HiSilicon driver

----------------------------------------------------------------
Bjorn Andersson (1):
      mailbox: qcom: Add msm8998 hmss compatible

Daniel Lezcano (1):
      mailbox/drivers/hisi: Consolidate the Kconfig for the MAILBOX

Fabien Dessenne (2):
      dt-bindings: mailbox: add STMicroelectronics STM32 IPCC binding
      mailbox: add STMicroelectronics STM32 IPCC driver

Geert Uytterhoeven (1):
      mailbox: Remove depends on HAS_DMA in case of platform dependency

Sibi Sankar (2):
      dt-bindings: mailbox: Add APSS shared binding for SDM845 SoCs
      mailbox: Add support for Qualcomm SDM845 SoCs

Stefan Wahren (1):
      mailbox: bcm2835: Fix of_xlate return value

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   2 +
 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  47 +++
 drivers/mailbox/Kconfig                            |  22 +-
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm2835-mailbox.c                  |   2 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   2 +
 drivers/mailbox/stm32-ipcc.c                       | 402 +++++++++++++++++++++
 7 files changed, 472 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
 create mode 100644 drivers/mailbox/stm32-ipcc.c

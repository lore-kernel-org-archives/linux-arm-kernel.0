From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 16 Aug 2018 21:42:03 +0530
Subject: [GIT PULL] Mailbox changes for v4.19
Message-ID: <CABb+yY10OBQaidRYXrGfi=n-PaaJU+sb6J3dJjZ0rjP+6AXB5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 0585df468e8f4481b78256a2bf09449290bfcbf3:

  Merge tag 'media/v4.18-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
(2018-08-02 16:55:42 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.19

for you to fetch changes up to 2bb7005696e2246baa88772341ca032ff09a63cb:

  mailbox: Add support for i.MX messaging unit (2018-08-15 09:53:07 +0530)

----------------------------------------------------------------
- xgene : potential null pointer fix

- omap : switch to spdx license and use of_device_get_match_data() to match data

- ti-msgmgr : cleanup and optimisation. New TI specific feature -
secure proxy thread.

- mediatek : add driver for CMDQ controller.

- nxp : add driver for MU controller

----------------------------------------------------------------
Dong Aisheng (1):
      dt-bindings: arm: fsl: add mu binding doc

Gustavo A. R. Silva (1):
      mailbox: xgene-slimpro: Fix potential NULL pointer dereference

Houlong Wei (2):
      dt-bindings: soc: Add documentation for the MediaTek GCE unit
      mailbox: mediatek: Add Mediatek CMDQ driver

Nishanth Menon (6):
      mailbox: ti-msgmgr: Get rid of unused structure members
      mailbox: ti-msgmgr: Allocate Rx channel resources only on request
      mailbox: ti-msgmgr: Change message count mask to be descriptor based
      mailbox: ti-msgmgr: Move the memory region name to descriptor
      dt-bindings: mailbox: Add support for secure proxy threads
      mailbox: ti-msgmgr: Add support for Secure Proxy

Oleksij Rempel (2):
      dt-bindings: mailbox: imx-mu: add generic MU channel support
      mailbox: Add support for i.MX messaging unit

Randy Dunlap (1):
      mailbox: add MODULE_LICENSE() for mtk-cmdq-mailbox.c

Suman Anna (2):
      mailbox/omap: switch to SPDX license identifier
      mailbox/omap: use of_device_get_match_data() to get match data

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  54 ++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |  57 ++
 .../bindings/mailbox/ti,secure-proxy.txt           |  50 ++
 drivers/mailbox/Kconfig                            |  16 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/imx-mailbox.c                      | 358 +++++++++++++
 drivers/mailbox/mailbox-xgene-slimpro.c            |   6 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 571 +++++++++++++++++++++
 drivers/mailbox/omap-mailbox.c                     |  31 +-
 drivers/mailbox/ti-msgmgr.c                        | 353 ++++++++++---
 include/dt-bindings/gce/mt8173-gce.h               |  44 ++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |  77 +++
 include/linux/omap-mailbox.h                       |   5 +-
 13 files changed, 1536 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
 create mode 100644 drivers/mailbox/imx-mailbox.c
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 include/dt-bindings/gce/mt8173-gce.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h

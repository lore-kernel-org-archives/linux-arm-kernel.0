From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Mon, 19 Jan 2015 18:48:25 +0800
Subject: [PATCH v4 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Message-ID: <1421664509-1807-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Fujitsu have an sdhci IP which is implemented in a SoC we're 
adding to mainline, the most recent series for that was sent 
here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317580.html

  We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Changes since v3:
* Cleaned out unnecessary include files.
* Removed unnecessary goto and error message.
* Changed both clocks from optional to required.
* Removed runtime PM support.

Changes since v2:
* Removed voltage-ranges because it is no longer a required property.
* Removed unnecessary error message.
* Used the devm_* managed functions and updated the error handling
accordingly.
* Removed #ifdef CONFIG_PM_RUNTIME and also updated some other #ifdef.
* Moved vendor specfic stuff prior to sdhci_add_host().
* Handled runtime PM on module removal.

Changes since v1:
* Thanks to Uffe, removed ARCH_MB86S7X dependency and separated
mmc patches to this patchset.
* Node name changed from "fujitsu,mb86s70-sdh30" to
"fujitsu,mb86s70-sdhci-3.0".

Thanks.

Vincent Yang (4):
  mmc: sdhci: add a voltage switch callback function
  mmc: sdhci: add a quirk for tuning work around
  mmc: sdhci: add a quirk for single block transactions
  mmc: sdhci: host: add new f_sdh30

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  30 +++
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci.c                           |  14 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 236 +++++++++++++++++++++
 include/linux/mmc/sdhci.h                          |   4 +
 7 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c

-- 
1.9.0

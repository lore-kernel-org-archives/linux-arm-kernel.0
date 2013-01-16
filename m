From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Jan 2013 14:13:55 +0100
Subject: [PATCH 0/5] mmc: mvsdio: use devm_ API to simplify/correct error
 paths.
Message-ID: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King pointed out a number of issues with the probe code in the
mvsdio driver and supplied a patch. This patchset uses a modified
version, converting resource allocations to devm API calls, and fixes
the error paths. The patches that then follow are from Thomas
Petazzoni making other cleanups and adding device tree. These patches
needed some changes after the swap to devm. The patches here replace
the earlier submitted patches with the same Subject.

Andrew Lunn (1):
  mmc: mvsdio: use devm_ API to simplify/correct error paths.

Thomas Petazzoni (4):
  mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
  mmc: mvsdio: use slot-gpio for card detect gpio
  mmc: mvsdio: implement a Device Tree binding
  mmc: mvsdio: add pinctrl integration

 .../devicetree/bindings/mmc/orion-sdio.txt         |   17 ++
 drivers/mmc/host/mvsdio.c                          |  187 ++++++++------------
 2 files changed, 93 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt

-- 
1.7.10.4

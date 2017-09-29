From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:25:36 +0200
Subject: [PATCH 0/5] firmware: arm_scpi: series with smaller improvements
Message-ID: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes smaller improvements to make all memory allocations
device-managed and eventually get rid of scpi_remove. This also improves
the cleanup path in scpi_probe.

Heiner Kallweit (5):
  firmware: arm_scpi: remove usage of drvdata and don't reset scpi_info to null
  firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
  firmware: arm_scpi: pre-populate dvfs info in scpi_probe
  firmware: arm_scpi: make freeing mbox channels device-managed
  firmware: arm_scpi: remove scpi_remove

 drivers/firmware/arm_scpi.c | 120 +++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 69 deletions(-)

-- 
2.14.2

From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 22:54:30 +0100
Subject: [PATCH 00/12] firmware: arm_scpi: series with smaller improvements
Message-ID: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After recent revert of all changes since 4.14 this is a resubmit of
the patch series, reduced to patches which should not cause any
regression.
Based on a remark from Kevin I added one patch for improving the
version info for pre-1.0 firmware that doesn't provide version
information.

Best should be to apply it to a devel branch first so that the
Baylibre Amlogic team can test before mainlining.

Heiner Kallweit (10):
  firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
  firmware: arm_scpi: make freeing mbox channels device-managed
  firmware: arm_scpi: make scpi_probe completely device-managed
  firmware: arm_scpi: improve struct dvfs_info to make code better readable
  firmware: arm_scpi: improve handling of protocol and firmware version subfields
  firmware: arm_scpi: improve struct sensor_value
  firmware: arm_scpi: silence sparse warnings
  firmware: arm_scpi: remove struct sensor_capabilities
  firmware: arm_scpi: use FIELD_GET/_PREP to simplify macro definitions
  firmware: arm_scpi: improve info message for pre-1.0 firmware

Sudeep Holla (2):
  firmware: arm_scpi: drop unnecessary type cast to scpi_shared_mem
  firmware: arm_scpi: remove all single element structures

 drivers/firmware/arm_scpi.c | 211 +++++++++++++++++++-------------------------
 1 file changed, 89 insertions(+), 122 deletions(-)

-- 
2.15.1

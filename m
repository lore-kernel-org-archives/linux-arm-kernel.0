From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 9 Oct 2017 18:27:05 +0100
Subject: [GIT PULL] firmware: arm_scpi: updates/cleanups for v4.15
Message-ID: <901d3720-a023-0af9-2b20-b7d7e8528571@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/scpi-updates-4.15

for you to fetch changes up to 430594c1c7f5051f0d99ed9d08d086d20587cdd1:

  firmware: arm_scpi: silence sparse warnings (2017-10-09 10:20:02 +0100)

----------------------------------------------------------------
ARM SCPI updates/cleanups for v4.15

1. Fixes to get rid of sparse warnings
2. Use of FIELD_GET and GENMASK for better subfields handling
3. Make mbox_free_channels device-managed helping in removing
unnecessary code
4. Various other cleanups to simplify and improve code readability

----------------------------------------------------------------
Heiner Kallweit (9):
      firmware: arm_scpi: remove usage of drvdata and don't reset
scpi_info to null
      firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
      firmware: arm_scpi: pre-populate dvfs info in scpi_probe
      firmware: arm_scpi: make freeing mbox channels device-managed
      firmware: arm_scpi: remove scpi_remove
      firmware: arm_scpi: improve struct dvfs_info to make code better
readable
      firmware: arm_scpi: improve handling of protocol and firmware
version subfields
      firmware: arm_scpi: improve struct sensor_value
      firmware: arm_scpi: silence sparse warnings

Sudeep Holla (2):
      firmware: arm_scpi: drop unnecessary type cast to scpi_shared_mem
      firmware: arm_scpi: remove all single element structures

 drivers/firmware/arm_scpi.c | 216
++++++++++++++++++--------------------------
 1 file changed, 87 insertions(+), 129 deletions(-)

From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Mar 2018 16:23:18 +0000
Subject: [GIT PULL] firmware: arm_scpi: updates for v4.17
Message-ID: <20180301162318.GB1752@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

As mentioned in the tag, this has similar content as the one I sent for
v4.15 which was reverted as it caused some regression on AmLogic platforms
and was too late to bisect down to the culprit commit.

This time the series got tested by Kevin Hilman, so it should be fine.

Please pull !

Regards,
Sudeep

--

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scpi-updates-4.17

for you to fetch changes up to 62c60efb63c868c1b1e54a1138c3295deae76eda:

  firmware: arm_scpi: improve info message for pre-1.0 firmware (2018-02-23 15:13:34 +0000)

----------------------------------------------------------------
ARM SCPI updates/cleanups for v4.17

1. Fixes to get rid of sparse warnings
2. Use of FIELD_GET and GENMASK for better subfields handling
3. Make mbox_free_channels device-managed helping in removing unnecessary code
4. Various other cleanups to simplify and improve code readability

Note that similar set of changes were merged in v4.15, however got reverted
through the commit 81faa5566864 ("firmware: arm_scpi: Revert updates made
during v4.15 merge window") for reasons mentioned in that commit.

This is the resend with the culprit patch removed. Kevin Hilman tested this
series on Amlogic and reported it to be fine.

----------------------------------------------------------------
Heiner Kallweit (10):
      firmware: arm_scpi: remove two unneeded devm_kfree's in scpi_remove
      firmware: arm_scpi: make freeing mbox channels device-managed
      firmware: arm_scpi: make scpi_probe completely device-managed
      firmware: arm_scpi: improve struct dvfs_info to make code better readable
      firmware: arm_scpi: improve handling of protocol and firmware version subfields
      firmware: arm_scpi: improve struct sensor_value
      firmware: arm_scpi: fix incorrect __iomem accesses using correct accessors
      firmware: arm_scpi: remove struct sensor_capabilities
      firmware: arm_scpi: use FIELD_GET/_PREP to simplify macro definitions
      firmware: arm_scpi: improve info message for pre-1.0 firmware

Sudeep Holla (2):
      firmware: arm_scpi: drop unnecessary type cast to scpi_shared_mem
      firmware: arm_scpi: remove all single element structures

 drivers/firmware/arm_scpi.c | 211 +++++++++++++++++++-------------------------
 1 file changed, 89 insertions(+), 122 deletions(-)

From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 2 Dec 2011 14:51:11 +0530
Subject: [PATCHv7 0/3] I2C driver updates
Message-ID: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series attempts to do the following

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.


Incorporated review comments:

 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header
 - Making the changelogs more descriptive.
 
This is rebased on Kevin's tree  for_3.2/fixes/i2c branch.


Acknowledge Balaji ,Santosh and Kevin for the review comments.


Shubhrajyoti D (3):
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition

 arch/arm/plat-omap/i2c.c      |   18 ++++++++
 drivers/i2c/busses/i2c-omap.c |   87 ++++++++++------------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 41 insertions(+), 65 deletions(-)

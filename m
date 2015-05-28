From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:32 +0530
Subject: [PATCH 00/12] i2c: pxa: Fixes, cleanup and support for pxa910 family
Message-ID: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes bugs/warnings, cleans up the code and adds
support for PXA910 family of devices to PXA I2C bus driver.

There has been one attempt made sometime back in 2012 to upstream
some of the patches from below list, but did not get follow up later.
I have consolidated all the patches, cleaned them up, splited into
logical changes, added new patches and submitting it now.

I tried to maintain authorship & Signoff except where I did some
significant changes to the code/logic.

Link to previous post:
http://permalink.gmane.org/gmane.linux.drivers.i2c/13557

Testing:
  - Boot tested on platform based on PXA1928
  - Probe is successfully passing

TODO:
  - Due to lack of client driver support as of now, could not
    able to do functionality testing from client. I am working
    on PMIC driver support which is over I2C, so will have good
    meaningful testing then.

Jett.Zhou (3):
  i2c: pxa: No need to set slave addr for i2c master mode reset
  i2c: pxa: Add reset operation when i2c bus busy
  i2c: pxa: Add support for pxa910/988 & new configuration features

Leilei Shang (1):
  i2c: pxa: keep i2c irq ON in suspend

Rob Herring (1):
  i2c: pxa: Add bus reset functionality

Shouming Wang (1):
  i2c: pxa: Return I2C_RETRY when timeout in pio mode

Vaibhav Hiremath (4):
  i2c: pxa: Reset i2c controller on timeout in interrupt and pio mode
  i2c: pxa: enable/disable irq across message xfer
  i2c: pxa: Update debug function to dump more info on error
  i2c:pxa: Use devm_ variants in probe function

Yi Zhang (1):
  i2c: pxa: enable/disable i2c module across msg xfer

Yipeng Yao (1):
  i2c: pxa: Remove compile warnning in 64bit mode

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |   7 +
 drivers/i2c/busses/i2c-pxa.c                      | 272 +++++++++++++++++-----
 include/linux/i2c/pxa-i2c.h                       |   2 +
 3 files changed, 225 insertions(+), 56 deletions(-)

-- 
1.9.1

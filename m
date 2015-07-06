From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:44 +0530
Subject: [PATCH-v3 00/11] i2c: pxa: Fixes,
 cleanup and support for pxa910 family
Message-ID: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
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
  - Basic testing on PMIC device on I2C-0 interface
  - Boot tested on platform based on PXA1928
  - Probe is successfully passing
  - Read few registers of PMIC (RTC, ID, etc...) during boot

V2 => V3
=======
Link to V2: http://www.spinics.net/lists/linux-i2c/msg20059.html

  - Removed PATCH [4/12] related to reset of I2C module.
    Suggested by "Robert Jarzmik"
  - Updated commit description for,
     PATCH [11/12]: Mentioned reasoning about moment of clk_get code.
     PATCH [12/12]: for DT property node.
  - Added Acked by "Robert Jarzmik" to patched which he acked.

V1 => V2:
========
Link to V1 - http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347012.html

  - Fixed all comments from "Robert Jarzmik" and "Wolfram Sang"
  - Dropped Patch
	05/12: using core bus reset implementation - under work.
               Will submit shortly.
	08/12: NAKed and dropped
  - Separated DT binding patch from driver changes, for easy merge



Leilei Shang (1):
  i2c: pxa: keep i2c irq ON in suspend

Shouming Wang (1):
  i2c: pxa: Return I2C_RETRY when timeout in pio mode

Vaibhav Hiremath (7):
  i2c: pxa: No need to set slave addr for i2c master mode reset
  i2c: pxa: Update debug function to dump more info on error
  i2c:pxa: Use devm_ variants in probe function
  Documentation: binding: add new property 'disable_after_xfer' to
    i2c-pxa
  i2c: pxa: Add support for pxa910/988 & new configuration features
  i2c: pxa: Add ILCR (tLow & tHigh) configuration support
  Documentation: binding: add sclk adjustment properties to i2c-pxa

Yi Zhang (1):
  i2c: pxa: enable/disable i2c module across msg xfer

Yipeng Yao (1):
  i2c: pxa: Remove compile warnning in 64bit mode

 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  18 ++
 drivers/i2c/busses/i2c-pxa.c                      | 262 ++++++++++++++++------
 2 files changed, 215 insertions(+), 65 deletions(-)

-- 
1.9.1

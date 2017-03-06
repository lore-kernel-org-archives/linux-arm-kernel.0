From: jon.mason@broadcom.com (Jon Mason)
Date: Mon,  6 Mar 2017 11:24:43 -0500
Subject: [PATCH v3 0/2] ARM: dts: BCM5301X: TWD WD and i2c Support
Message-ID: <1488817485-7503-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v3:
* Dropped the "Correct GIC_PPI interrupt flags" patch from the series,
  as it was already accepted
* Disabled the i2c bus by default, to follow current convention (per
  Florian)

Changes in v2:
* Rafal discovered an issue with the GIC_PPI flags being incorrect.
  Since there was a dependency on that DT entry in this series, I added
  a patch to correct the issue and reworked the TWD patch with the
  changes.


These seemed to have been lost sometime last year.  See
https://lkml.org/lkml/2016/5/11/953

I am dropping the syscon reboot from the series, as I believe that was
the sticking point, and resending the TWD and i2c patches.


Jon Mason (2):
  ARM: dts: bcm5301x: Add TWD WD Support to DT
  ARM: dts: bcm5301x: Add I2C support to the DT

 arch/arm/boot/dts/bcm5301x.dtsi | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.7.4

From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 21 Apr 2016 20:11:15 +0000
Subject: [PATCH RFT V2 0/3] iio: mxs-lradc: implement PM ops
Message-ID: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series simplifies TS registration and implements suspend/resume
support for mxs-lradc.

Patch 1: simplify TS registration
Patch 2: refactor mxs-lradc in order to prepare PM implementation
Patch 3: implement suspend/resume support

These patches has been tested with i.MX23 and i.MX28 but without
a touchscreen. I added only a bogus touchscreen in devicetree.

It would be nice if someone with a real touchscreen could test it.

Changes in V2:
- rebase on iio/testing since patch 2 and 3 from V1 has been applied
- also remove input_unregister_device in patch 1
- use mask of virtual channels for IRQ disabling in patch 2

Stefan Wahren (3):
  iio: mxs-lradc: simplify TS registration
  iio: mxs-lradc: disable only masked channels in mxs_lradc_hw_stop
  iio: mxs-lradc: implement suspend/resume support

 drivers/iio/adc/mxs-lradc.c |   81 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 15 deletions(-)

-- 
1.7.9.5

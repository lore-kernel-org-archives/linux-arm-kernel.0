From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 15 Nov 2012 17:43:29 +0530
Subject: [PATCH 0/4] i2c-s3c2410: Fix a bug and optimize code
Message-ID: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following set of patches fixes a bug in i2c-s3c2410 driver
with respect to the functioning of dedicated HDMIPHY channel.
1. Removing unwanted spinlock
2. Correcting the Stop sequence
3. Optimizing the wait loop for bus idle.
4. Removing unnecessary HDMI special cases
Respectively.

Daniel Kurtz (4):
  i2c-s3c2410: grab adapter lock while changing i2c clock
  i2c-s3c2410: do not generate STOP for QUIRK_HDMIPHY
  i2c-s3c2410: use exponential back off while polling for bus idle
  i2c-s3c2410: do not special case HDMIPHY stuck bus detection

 drivers/i2c/busses/i2c-s3c2410.c |  134 ++++++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 43 deletions(-)

-- 
1.7.9.5

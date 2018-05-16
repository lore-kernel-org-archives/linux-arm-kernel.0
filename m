From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 16 May 2018 15:37:02 +0200
Subject: [PATCH RFC 1/6] ARM: bcm2835: Add GET_THROTTLED firmware property
In-Reply-To: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1526477827-10859-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Raspberry Pi firmware provides a mailbox property to detect
under-voltage conditions. Here is the current definition.

The u32 value returned by the firmware is divided into 2 parts:
  - lower 16-bits are the live value
  - upper 16-bits are the history or sticky value

  Bits:
  0: under-voltage
  1: arm frequency capped
  2: currently throttled 
  16: under-voltage has occurred
  17: arm frequency capped has occurred
  18: throttling has occurred

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 8ee8991..c4a5c9e 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -75,6 +75,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
 	RPI_FIRMWARE_GET_CUSTOMER_OTP =                       0x00030021,
 	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
+	RPI_FIRMWARE_GET_THROTTLED =                          0x00030046,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
-- 
2.7.4

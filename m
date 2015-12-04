From: eric@anholt.net (Eric Anholt)
Date: Fri,  4 Dec 2015 09:45:45 -0800
Subject: [PATCH v2 2/5] ARM: bcm2835: Define two new packets from the latest
 firmware.
In-Reply-To: <1449251148-19344-1-git-send-email-eric@anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
Message-ID: <1449251148-19344-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These packets give us direct access to the firmware's power management
code, as opposed to GET/SET_POWER_STATE packets that only had a couple
of domains implemented.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index c07d74a..3fb3571 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -72,10 +72,12 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_ENABLE_QPU =                         0x00030012,
 	RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
 	RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
+	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
 	RPI_FIRMWARE_SET_TURBO =                              0x00038009,
+	RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
-- 
2.6.2

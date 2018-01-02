From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  2 Jan 2018 15:19:18 +0200
Subject: [PATCH 1/4] ARM: bcm2835: sync firmware properties with downstream
In-Reply-To: <cover.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
Message-ID: <f791c01097606f29d9572bcdfe3e4aa16d2022e8.1514898134.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add latest firmware property tags from the latest Raspberry Pi downstream
kernel. This is needed for the GPIO tags, so we can control the GPIO
multiplexor lines.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index cb979ad90401..50df5b28d2c9 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -63,6 +63,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_MIN_VOLTAGE =                        0x00030008,
 	RPI_FIRMWARE_GET_TURBO =                              0x00030009,
 	RPI_FIRMWARE_GET_MAX_TEMPERATURE =                    0x0003000a,
+	RPI_FIRMWARE_GET_STC =                                0x0003000b,
 	RPI_FIRMWARE_ALLOCATE_MEMORY =                        0x0003000c,
 	RPI_FIRMWARE_LOCK_MEMORY =                            0x0003000d,
 	RPI_FIRMWARE_UNLOCK_MEMORY =                          0x0003000e,
@@ -72,12 +73,22 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_ENABLE_QPU =                         0x00030012,
 	RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
 	RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
+	RPI_FIRMWARE_GET_CUSTOMER_OTP =                       0x00030021,
 	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
 	RPI_FIRMWARE_SET_TURBO =                              0x00038009,
+	RPI_FIRMWARE_SET_CUSTOMER_OTP =                       0x00038021,
 	RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
+	RPI_FIRMWARE_GET_GPIO_STATE =                         0x00030041,
+	RPI_FIRMWARE_SET_GPIO_STATE =                         0x00038041,
+	RPI_FIRMWARE_SET_SDHOST_CLOCK =                       0x00038042,
+	RPI_FIRMWARE_GET_GPIO_CONFIG =                        0x00030043,
+	RPI_FIRMWARE_SET_GPIO_CONFIG =                        0x00038043,
+	RPI_FIRMWARE_GET_PERIPH_REG =                         0x00030045,
+	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
+
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
@@ -91,6 +102,8 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_FRAMEBUFFER_GET_VIRTUAL_OFFSET =         0x00040009,
 	RPI_FIRMWARE_FRAMEBUFFER_GET_OVERSCAN =               0x0004000a,
 	RPI_FIRMWARE_FRAMEBUFFER_GET_PALETTE =                0x0004000b,
+	RPI_FIRMWARE_FRAMEBUFFER_GET_TOUCHBUF =               0x0004000f,
+	RPI_FIRMWARE_FRAMEBUFFER_GET_GPIOVIRTBUF =            0x00040010,
 	RPI_FIRMWARE_FRAMEBUFFER_RELEASE =                    0x00048001,
 	RPI_FIRMWARE_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT = 0x00044003,
 	RPI_FIRMWARE_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT =  0x00044004,
@@ -100,6 +113,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_FRAMEBUFFER_TEST_VIRTUAL_OFFSET =        0x00044009,
 	RPI_FIRMWARE_FRAMEBUFFER_TEST_OVERSCAN =              0x0004400a,
 	RPI_FIRMWARE_FRAMEBUFFER_TEST_PALETTE =               0x0004400b,
+	RPI_FIRMWARE_FRAMEBUFFER_TEST_VSYNC =                 0x0004400e,
 	RPI_FIRMWARE_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT =  0x00048003,
 	RPI_FIRMWARE_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT =   0x00048004,
 	RPI_FIRMWARE_FRAMEBUFFER_SET_DEPTH =                  0x00048005,
@@ -108,6 +122,10 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_FRAMEBUFFER_SET_VIRTUAL_OFFSET =         0x00048009,
 	RPI_FIRMWARE_FRAMEBUFFER_SET_OVERSCAN =               0x0004800a,
 	RPI_FIRMWARE_FRAMEBUFFER_SET_PALETTE =                0x0004800b,
+	RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF =               0x0004801f,
+	RPI_FIRMWARE_FRAMEBUFFER_SET_GPIOVIRTBUF =            0x00048020,
+	RPI_FIRMWARE_FRAMEBUFFER_SET_VSYNC =                  0x0004800e,
+	RPI_FIRMWARE_FRAMEBUFFER_SET_BACKLIGHT =              0x0004800f,
 
 	RPI_FIRMWARE_VCHIQ_INIT =                             0x00048010,
 
-- 
2.15.1

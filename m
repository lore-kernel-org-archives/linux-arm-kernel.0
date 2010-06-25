From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Fri, 25 Jun 2010 10:31:33 -0300
Subject: [PATCH] mx27_3ds: add support for the keypad
Message-ID: <4C24AFB5.4090909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27_3ds: add support for the keypad

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

---
On branch imx-for-2.6.35
  arch/arm/mach-mx2/mach-mx27_3ds.c |   23 +++++++++++++++++++++++
  1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-mx27_3ds.c 
b/arch/arm/mach-mx2/mach-mx27_3ds.c
index b2f4e0d..411f0b4 100644
--- a/arch/arm/mach-mx2/mach-mx27_3ds.c
+++ b/arch/arm/mach-mx2/mach-mx27_3ds.c
@@ -20,6 +20,7 @@

  #include <linux/platform_device.h>
  #include <linux/gpio.h>
+#include <linux/input/matrix_keypad.h>
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/time.h>
@@ -58,6 +59,27 @@ static unsigned int mx27pdk_pins[] = {
      PF23_AIN_FEC_TX_EN,
  };

+/*
+ * Matrix keyboard
+ */
+
+static const uint32_t mx27_3ds_keymap[] = {
+    KEY(0, 0, KEY_UP),
+    KEY(0, 1, KEY_DOWN),
+    KEY(1, 0, KEY_RIGHT),
+    KEY(1, 1, KEY_LEFT),
+    KEY(1, 2, KEY_ENTER),
+    KEY(2, 0, KEY_F6),
+    KEY(2, 1, KEY_F8),
+    KEY(2, 2, KEY_F9),
+    KEY(2, 3, KEY_F10),
+};
+
+static struct matrix_keymap_data mx27_3ds_keymap_data = {
+    .keymap        = mx27_3ds_keymap,
+    .keymap_size    = ARRAY_SIZE(mx27_3ds_keymap),
+};
+
  static struct imxuart_platform_data uart_pdata = {
      .flags = IMXUART_HAVE_RTSCTS,
  };
@@ -71,6 +93,7 @@ static void __init mx27pdk_init(void)
      mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
          "mx27pdk");
      mxc_register_device(&mxc_uart_device0, &uart_pdata);
+    mxc_register_device(&imx_kpp_device, &mx27_3ds_keymap_data);
      platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
  }

-- 
1.7.0.4

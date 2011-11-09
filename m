From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 10 Nov 2011 07:15:18 +0800
Subject: CONFIG_USB_GADGET_PXA27X
In-Reply-To: <20111109220144.GA17605@legolas.emea.dhcp.ti.com>
References: <1320870640.27598.33.camel@x61.thuisdomein>
 <20111109220144.GA17605@legolas.emea.dhcp.ti.com>
Message-ID: <CAN1soZzFMg+d5H2nCb-w_FAjVCQQHF0Fu-prQAbuEQtqwbtDqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 6:01 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Nov 09, 2011 at 09:30:40PM +0100, Paul Bolle wrote:
>> 0) Commit 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b ("usb: gadget: allow
>> multiple gadgets to be built") dropped config USB_GADGET_PXA27X. But
>> currently there are still five references to CONFIG_USB_GADGET_PXA27X
>> (all in arch/arm/mach-pxa).
>>
>> 1) A naive fix would be to simply replace CONFIG_USB_GADGET_PXA27X with
>> CONFIG_USB_PXA27X everywhere (and change CONFIG_USB_GADGET_PXA27X_MODULE
>> likewise). Would that be correct?
>
> Eric, any comments ?
>
> --
> balbi
>

Yes, we need replace these macros in both mach-pxa and configs directories.

Thanks
Haojian



From: Haojian Zhuang <haojian.zhuang@hexinfolabs.org>
To: haojian.zhuang at gmail.com
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Subject: [PATCH] ARM: pxa: fix inconsistent CONFIG_USB_PXA27X
Date: Thu, 10 Nov 2011 07:13:07 +0800
Message-Id: <1320880387-13440-1-git-send-email-haojian.zhuang@hexinfolabs.org>
X-Mailer: git-send-email 1.7.4.1

From: Haojian Zhuang <haojian.zhuang@marvell.com>

Since CONFIG_USB_GADGET_PXA27X and other macros are renamed to
CONFIG_USB_PXA27X. Update them in arch/arm/mach-pxa and arch/arm/configs
to keep consistent.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/ezx_defconfig           |    2 +-
 arch/arm/configs/imote2_defconfig        |    2 +-
 arch/arm/configs/magician_defconfig      |    2 +-
 arch/arm/configs/zeus_defconfig          |    2 +-
 arch/arm/mach-pxa/balloon3.c             |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c       |    2 +-
 arch/arm/mach-pxa/gumstix.c              |    2 +-
 arch/arm/mach-pxa/include/mach/palm27x.h |    4 ++--
 arch/arm/mach-pxa/palm27x.c              |    4 ++--
 arch/arm/mach-pxa/palmtc.c               |    2 +-
 arch/arm/mach-pxa/vpac270.c              |    2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 227a477..d95763d 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -287,7 +287,7 @@ CONFIG_USB=y
 # CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PXA27X=y
+CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_MMC=y
diff --git a/arch/arm/configs/imote2_defconfig
b/arch/arm/configs/imote2_defconfig
index 176ec22..fd996bb 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -263,7 +263,7 @@ CONFIG_USB=y
 # CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PXA27X=y
+CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_MMC=y
diff --git a/arch/arm/configs/magician_defconfig
b/arch/arm/configs/magician_defconfig
index a88e64d..443675d 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -132,7 +132,7 @@ CONFIG_USB_MON=m
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VBUS_DRAW=500
-CONFIG_USB_GADGET_PXA27X=y
+CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 # CONFIG_USB_ETH_RNDIS is not set
 CONFIG_USB_GADGETFS=m
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 59577ad..547a3c1 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -140,7 +140,7 @@ CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_MCT_U232=m
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_PXA27X=y
+CONFIG_USB_PXA27X=y
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
 CONFIG_USB_FILE_STORAGE=m
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index d0f1411..2863aed 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -307,7 +307,7 @@ static inline void balloon3_mmc_init(void) {}
 /******************************************************************************
  * USB Gadget
  ******************************************************************************/
-#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+#if defined(CONFIG_USB_PXA27X)||defined(CONFIG_USB_PXA27X_MODULE)
 static void balloon3_udc_command(int cmd)
 {
 	if (cmd == PXA2XX_UDC_CMD_CONNECT)
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
b/arch/arm/mach-pxa/colibri-pxa320.c
index d2c6631..db3a938 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -146,7 +146,7 @@ static void __init colibri_pxa320_init_eth(void)
 static inline void __init colibri_pxa320_init_eth(void) {}
 #endif /* CONFIG_AX88796 */

-#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+#if defined(CONFIG_USB_PXA27X)||defined(CONFIG_USB_PXA27X_MODULE)
 static struct gpio_vbus_mach_info colibri_pxa320_gpio_vbus_info = {
 	.gpio_vbus		= mfp_to_gpio(MFP_PIN_GPIO96),
 	.gpio_pullup		= -1,
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index deaa111..4aa3dba 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -106,7 +106,7 @@ static void __init gumstix_mmc_init(void)
 }
 #endif

-#ifdef CONFIG_USB_GADGET_PXA25X
+#ifdef CONFIG_USB_PXA25X
 static struct gpio_vbus_mach_info gumstix_udc_info = {
 	.gpio_vbus		= GPIO_GUMSTIX_USB_GPIOn,
 	.gpio_pullup		= GPIO_GUMSTIX_USB_GPIOx,
diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h
b/arch/arm/mach-pxa/include/mach/palm27x.h
index f80bbe2..d4eac3d 100644
--- a/arch/arm/mach-pxa/include/mach/palm27x.h
+++ b/arch/arm/mach-pxa/include/mach/palm27x.h
@@ -37,8 +37,8 @@ extern void __init palm27x_lcd_init(int power,
 #define palm27x_lcd_init(power, mode)	do {} while (0)
 #endif

-#if	defined(CONFIG_USB_GADGET_PXA27X) || \
-	defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+#if	defined(CONFIG_USB_PXA27X) || \
+	defined(CONFIG_USB_PXA27X_MODULE)
 extern void __init palm27x_udc_init(int vbus, int pullup,
 					int vbus_inverted);
 #else
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 325c245..fbc10d7 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -164,8 +164,8 @@ void __init palm27x_lcd_init(int power, struct
pxafb_mode_info *mode)
 /******************************************************************************
  * USB Gadget
  ******************************************************************************/
-#if	defined(CONFIG_USB_GADGET_PXA27X) || \
-	defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+#if	defined(CONFIG_USB_PXA27X) || \
+	defined(CONFIG_USB_PXA27X_MODULE)
 static struct gpio_vbus_mach_info palm27x_udc_info = {
 	.gpio_vbus_inverted	= 1,
 };
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 6ad4a6c..9c27b01 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -338,7 +338,7 @@ static inline void palmtc_mkp_init(void) {}
 /******************************************************************************
  * UDC
  ******************************************************************************/
-#if defined(CONFIG_USB_GADGET_PXA25X)||defined(CONFIG_USB_GADGET_PXA25X_MODULE)
+#if defined(CONFIG_USB_PXA25X)||defined(CONFIG_USB_PXA25X_MODULE)
 static struct gpio_vbus_mach_info palmtc_udc_info = {
 	.gpio_vbus		= GPIO_NR_PALMTC_USB_DETECT_N,
 	.gpio_vbus_inverted	= 1,
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 5f8490a..3a1fa1d 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -343,7 +343,7 @@ static inline void vpac270_uhc_init(void) {}
 /******************************************************************************
  * USB Gadget
  ******************************************************************************/
-#if defined(CONFIG_USB_GADGET_PXA27X)||defined(CONFIG_USB_GADGET_PXA27X_MODULE)
+#if defined(CONFIG_USB_PXA27X)||defined(CONFIG_USB_PXA27X_MODULE)
 static struct gpio_vbus_mach_info vpac270_gpio_vbus_info = {
 	.gpio_vbus		= GPIO41_VPAC270_UDC_DETECT,
 	.gpio_pullup		= -1,
-- 
1.7.4.1

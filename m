From: hongjiujing@gmail.com (tommy tommy)
Date: Fri, 30 Oct 2009 12:08:57 +0800
Subject: USB WIFI RT3070 Compile Patch for ARM
Message-ID: <48cbf6bf0910292108o2c23908ej1cc46282d91f4776@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB WIFI:RT3070

Official driver :http://www.ralinktech.com/support.php?s=2[RT3070USB(RT307x)]

Linux:2.6.24.2

MCU:ARMV6 ARM1176

Patch for Compiling for ARM


--- rt3070_test_ok/os/linux/config.mk    2009-10-30 10:55:07.000000000 +0800
+++ /home/tommy/Desktop/2009_0525_RT3070_Linux_STA_v2.1.1.0/os/linux/
config.mk    2009-05-21 11:33:56.000000000 +0800
@@ -1,4 +1,3 @@
 # Support ATE function
 HAS_ATE=n

@@ -7,12 +6,12 @@

 #ifdef WPA_SUPPLICANT_SUPPORT
 # Support Wpa_Supplicant
-HAS_WPA_SUPPLICANT=y
+HAS_WPA_SUPPLICANT=n
 #endif // WPA_SUPPLICANT_SUPPORT //

 #ifdef NATIVE_WPA_SUPPLICANT_SUPPORT
 # Support Native WpaSupplicant for Network Maganger
-HAS_NATIVE_WPA_SUPPLICANT_SUPPORT=y
+HAS_NATIVE_WPA_SUPPLICANT_SUPPORT=n
 #endif // NATIVE_WPA_SUPPLICANT_SUPPORT //

 #Support Net interface block while Tx-Sw queue full
@@ -285,17 +284,6 @@
     endif
 endif

-ifeq ($(PLATFORM),ARM)
-    # Linux 2.6
-    EXTRA_CFLAGS := $(WFLAGS) -I$(RT28xx_DIR)/include
-endif
-
 ifeq ($(PLATFORM),IXP)
         EXTRA_CFLAGS := -v $(WFLAGS) -I$(RT28xx_DIR)/include -mbig-endian
 endif


Tommy at China
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091030/d5fbfd36/attachment.htm>

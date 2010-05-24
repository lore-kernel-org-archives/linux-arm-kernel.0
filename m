From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 May 2010 21:55:38 +0200
Subject: [PATCH 03/16] arm/mx1: add CONFIG_VIDEO_MX1 to defconfig
In-Reply-To: <20100524195430.GA28403@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
Message-ID: <1274730951-29106-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx1 is the only machine type that can have this device, so add it to
its defconfig to get more compile coverage.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx1_defconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mx1_defconfig b/arch/arm/configs/mx1_defconfig
index f575070..208060e 100644
--- a/arch/arm/configs/mx1_defconfig
+++ b/arch/arm/configs/mx1_defconfig
@@ -697,6 +697,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_PCF50633 is not set
+CONFIG_MEDIA_SUPPORT=m
 
 #
 # Multimedia devices
@@ -705,13 +706,16 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multimedia core support
 #
-# CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_DEV=m
 # CONFIG_DVB_CORE is not set
 # CONFIG_VIDEO_MEDIA is not set
 
 #
 # Multimedia drivers
 #
+CONFIG_VIDEO_V4L2=m
+CONFIG_SOC_CAMERA=m
+CONFIG_VIDEO_MX1=m
 # CONFIG_DAB is not set
 
 #
-- 
1.7.0

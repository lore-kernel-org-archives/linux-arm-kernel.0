From: r65037@freescale.com (Zhu Richard-R65037)
Date: Fri, 24 Sep 2010 11:57:55 +0800
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver
In-Reply-To: <1285300467-5158-5-git-send-email-r65037@freescale.com>
References: <1285300467-5158-1-git-send-email-r65037@freescale.com>
	<1285300467-5158-2-git-send-email-r65037@freescale.com>
	<1285300467-5158-3-git-send-email-r65037@freescale.com>
	<1285300467-5158-4-git-send-email-r65037@freescale.com>
	<1285300467-5158-5-git-send-email-r65037@freescale.com>
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D4BDC@zch01exm22.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
Why I can't use the --compose to post the additional msg before sending
out the serial patches?
:(
Anyway, paste them here:

Hi Wolfram:
Here are the patches that enable the sdhci of i.MX51.
The IO and WP functions are verified on i.MX51 BBG board.
The missing bits of the HOST_CONTROL and so on had been made up in the
4-3 patch.


Hi Uwe:
I would change MSL part to the "dynamically allocated method" later.

Any review/comments/suggestions are appreciated.
Thanks in advanced.


Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu at freescale.com 


-----Original Message-----
From: Zhu Richard-R65037 
Sent: Friday, 24 September, 2010 11:54
To: w.sang at pengutronix.de; u.kleine-koenig at pengutronix.de;
linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org; Zhu Richard-R65037
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver

Enable the fsl esdhc driver on mx51 platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig
b/arch/arm/configs/mx51_defconfig index a665ecb..4f3067b 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,8 +106,13 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_IMX=y
+# CONFIG_MMC_MXC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_RTC_CLASS=y
--
1.7.0

From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 24 May 2013 15:28:13 +0200
Subject: [PATCH] ARM: ux500: select SND_SOC_UX500 for ux500
Message-ID: <1369402093-27817-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ux500 specific ALSA SoC drivers by default on u8500_defconfig.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hi Linus,

As I noticed that you just updated your ux500-defconfig branch, and the ux500
sound driver should be working fine in the next kernel, I'm sending a patch to
enable it by default.  This applies on top of your recent commit "ARM: ux500:
update defconfig base".

Thanks,
Fabio

 arch/arm/configs/u8500_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index da0614a..da353e0 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -69,6 +69,11 @@ CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_AB8500=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_UX500=y
+CONFIG_SND_SOC_UX500_MACH_MOP500=y
 CONFIG_USB=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_UX500=y
-- 
1.8.2

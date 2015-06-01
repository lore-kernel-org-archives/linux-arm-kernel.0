From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 20:35:02 +0200
Subject: [GIT PULL] qcom SoC changes for 4.2-1
In-Reply-To: <2248044.jBzoST62A5@wuerfel>
References: <alpine.DEB.2.02.1505261449220.26936@galak-ubuntu.qualcomm.com>
 <alpine.DEB.2.02.1505281055020.17861@galak-ubuntu.qualcomm.com>
 <2248044.jBzoST62A5@wuerfel>
Message-ID: <3126465.IVbQcV0VyT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 14:42:01 Arnd Bergmann wrote:
> On Thursday 28 May 2015 10:55:39 Kumar Gala wrote:
> > Qualcomm ARM Based SoC Updates for v4.2-1
> > 
> > * Added Subsystem Power Manager (SPM) driver
> > * Split out 32-bit specific SCM code
> > * Added HDCP SCM call
> > 
> > 
> 
> Pulled into next/drivers, thanks!
> 

I've had to apply this patch on top of our for-next branch to make it
build for randconfig.

Can you check that this makes sense?

	Arnd

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5eea374c8fa6..01aa2fd3514d 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -13,6 +13,8 @@ config QCOM_GSBI
 config QCOM_PM
 	bool "Qualcomm Power Management"
 	depends on ARCH_QCOM && !ARM64
+	select QCOM_SCM
+	select ARM_CPU_SUSPEND
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in

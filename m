From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 13:20:25 +0100
Subject: [PATCH 14/15] ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
In-Reply-To: <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-15-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50950C09.6000108@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
> AM33XX PM code depends on Mailbox module for IPC
> between MPU and WKUP_M3.

OK, but what if I try to build for AM33xx without starting from 
omap2plus_defconfig?

IOW, instead of changing the default defconfig, AM33xx should select 
this when PM
is enabled.   Something like the (untested) change below.

Kevin


diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d669e22..93c1a37 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,6 +109,7 @@ config SOC_AM33XX
  	bool "AM33XX support"
  	default y
  	select ARM_CPU_SUSPEND if PM
+        select OMAP_MBOX_FWK if PM
  	select CPU_V7
  	select MULTI_IRQ_HANDLER

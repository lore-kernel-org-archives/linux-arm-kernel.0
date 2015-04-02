From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 16:17:49 +0200
Subject: [GIT PULL] at91: multiplatform for 4.1 #1
In-Reply-To: <1426785269-6484-1-git-send-email-nicolas.ferre@atmel.com>
References: <1426785269-6484-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4695444.mEPNvRWLFJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 March 2015 18:14:29 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the real switch to multi-platform for AT91: after all the preparation
> work that has been done, here we are! And there's also an additional cleanup on
> top of that...
> I stacked this material on top of my previous "at91-cleanup3" tag that I had sent
> you earlier this week. As all my cleanup material is also on top of the fixes
> tags (that you already have), these patches are also adapted to match this
> state and avoid conflicts.
> So, you can have this tag in your "multiplatform" branch separated, like I did,
> or simply stacked on top or the AT91 cleanup material.

I got a build error with legacy (non-multi) platforms when ARCH_AT91 is enabled
and needed this change on top:

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e2cd30f6c23d..fd95f34945f4 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_AT91
 	bool "Atmel SoCs"
+	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_AT91
 	select PINCTRL

Can you check if that is the right approach and submit it as a proper
patch?

	Arnd

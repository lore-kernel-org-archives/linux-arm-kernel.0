From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 04 Apr 2014 16:52:17 +0200
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <1396620845.19661.14.camel@x220>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
 <8799740.0uZJLUBGY1@wuerfel> <1396620845.19661.14.camel@x220>
Message-ID: <1396623137.19661.20.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-04 at 16:14 +0200, Paul Bolle wrote:
> Correct, see http://thread.gmane.org/gmane.linux.kernel/1646112 . It
> seems nothing happened after that. I'm planning on sending a reminder if
> PLAT_SPEAR_SINGLE is still mentioned in v3.15-rc1.

It turns out my patch was incorrect. This chunk

@@ -95,7 +94,6 @@ config MACH_SPEAR600
     	  Supports ST SPEAr600 boards configured via the device-treesource "arch/arm/mach-spear6xx/Kconfig"
 
 config ARCH_SPEAR_AUTO
-	def_bool PLAT_SPEAR_SINGLE
 	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
 	select ARCH_SPEAR3XX
 

is bogus. It leaves ARCH_SPEAR_AUTO without a type. So I'll have to
redo, but I'll wait until v3.15-rc1.


Paul Bolle

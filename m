From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jul 2014 23:29:33 +0200
Subject: [PATCH RESEND v2] bus: ARM CCN PMU driver
In-Reply-To: <201407232223.39341.arnd@arndb.de>
References: <1406050379-15199-1-git-send-email-pawel.moll@arm.com>
 <201407232223.39341.arnd@arndb.de>
Message-ID: <39594081.3C5fmmXpMJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 July 2014 22:23:38 Arnd Bergmann wrote:
> On Tuesday 22 July 2014, Pawel Moll wrote:
> > Driver providing perf backend for ARM Cache Coherent Network
> > interconnect. Supports counting all hardware events and crosspoint
> > watchpoints.
> > 
> > Currently works with CCN-504 only, although there should be
> > no changes required for CCN-508 (just impossible to test it now).
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> Applied to next/drivers, thanks!

I'm getting build errors with CONFIG_PERF_EVENTS disabled. 
Is the patch below the right answer, or should we still load
the driver and #ifdef the perf-events code?

It seems to me that the driver doesn't do anything besides
perf events, but I could be missing something.

	Arnd

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 5c0c2764839f..603eb1be4f6a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -53,6 +53,7 @@ config ARM_CCI
 config ARM_CCN
 	bool "ARM CCN driver support"
 	depends on ARM || ARM64
+	depends on PERF_EVENTS
 	help
 	  PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
 	  interconnect.

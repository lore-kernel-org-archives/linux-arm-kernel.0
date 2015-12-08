From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 17:49:20 +0100
Subject: [PATCH] regulator: add regulator_sync_voltage inline dummy
In-Reply-To: <20151208163739.GS5727@sirena.org.uk>
References: <1983152.2iYiBkp4xd@wuerfel> <20151208163739.GS5727@sirena.org.uk>
Message-ID: <18141514.YrJxqxh5jL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 16:37:39 Mark Brown wrote:
> On Tue, Dec 08, 2015 at 04:43:35PM +0100, Arnd Bergmann wrote:
> 
> > This modifies the API header so we provide a static inline function
> > with the same prototype as the normal function of this name. This matches
> > what we do for all other regulator API functions and avoids the build
> > error.
> 
> We don't do this for *all* regulator API functions - there's some where
> using them strongly suggests that there is actually a dependency on the
> regulator API.  This does seem like it might be falling into the
> specialist category...
> 

Ok, got it.

I guess we'll want something like the patch below in the cpufreq git, right?

	Arnd

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 235a1ba73d92..b1f8a73e5a94 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -226,7 +226,7 @@ config ARM_TEGRA20_CPUFREQ
 
 config ARM_TEGRA124_CPUFREQ
 	tristate "Tegra124 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT
+	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.

From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 3 Jan 2012 16:02:01 +0000
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <4F031698.4010501@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <201112081537.04789.arnd.bergmann@linaro.org> <4F031698.4010501@linaro.org>
Message-ID: <201201031602.01072.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 January 2012, Daniel Lezcano wrote:
> drivers/idle/intel_idle.c => drivers/cpuidle/intel.c
> drivers/acpi/processor_idle.c => drivers/cpuidle/acpi.c
> 
> arch/arm/mach-omap2/cpuidle34xx.c => drivers/cpuidle/omap-34xx.c
> arch/arm/mach-omap2/cpuidle44xx.c => drivers/cpuidle/omap-44xx.c
> arch/arm/mach-shmobile/cpuidle.c  => drivers/cpuidle/arm-shmobile.c
> arch/arm/mach-davinci/cpuidle.c => drivers/cpuidle/davinci.c
> arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/at91.c
> arch/arm/mach-s3c64xx/cpuidle.c => drivers/cpuidle/s3c64xx.c
> arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/exynos.c
> arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/kirkwood.c
> arch/arcm/mach-msm/idle.S => drivers/cpuidle/msm.S
> 
> That could be a first step and then we move the other archs which could 
> be a bit more tricky like the powerpc.
> 
> Does it make sense ?

Sounds good to me. However, if any of the drivers can be built as
loadable modules, or if there is any intention to make them so,
the file name should be globally unique and follow a common naming
scheme, e.g. idle-intel.c, idle-acpi.c, ...

	Arnd

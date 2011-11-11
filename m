From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 11 Nov 2011 13:53:35 -0800
Subject: [PATCH v4 04/10] arm/tegra: prepare early init for multiple
 tegra variants
In-Reply-To: <1321010541-31337-5-git-send-email-pdeschrijver@nvidia.com>
References: <1321010541-31337-1-git-send-email-pdeschrijver@nvidia.com>
 <1321010541-31337-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17408058B9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Friday, November 11, 2011 4:22 AM:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.

> diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
> -void tegra_assert_system_reset(char mode, const char *cmd);

Given you explicitly removed that from the header...

> +++ b/arch/arm/mach-tegra/clock.c
>  void tegra_assert_system_reset(char mode, const char *cmd)

Maybe you want to make it static in the .c file too?

-- 
nvpublic

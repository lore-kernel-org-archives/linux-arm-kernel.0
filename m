From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 8 Dec 2011 09:57:33 -0800
Subject: [PATCH v6 04/10] arm/tegra: prepare early init for multiple
 tegra variants
In-Reply-To: <1323348254-29072-5-git-send-email-pdeschrijver@nvidia.com>
References: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
 <1323348254-29072-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B77A7E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, December 08, 2011 5:44 AM:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.

This one really should be at least 3 separate patches:
* s/tegra_init_early/tegra20_init_early/ in machine descriptions
* Switch reset mechanism from CAR to PMC
* tegra_init_cache modifications
* Not sure if all the ifdef additions go in the above, or if some should be
  separate?

Still, I think it's probably OK to go in as it is even if it isn't optimal.

-- 
nvpublic

From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 26 Jan 2012 12:44:45 -0800
Subject: [PATCH v1 8/8] ARM: tegra: support for secondary cores on Tegra30
In-Reply-To: <1327597641-7519-9-git-send-email-pdeschrijver@nvidia.com>
References: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
 <1327597641-7519-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB8247E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, January 26, 2012 10:07 AM:
> Add support for bringing up secondary cores on Tegra30. On Tegra30 secondary
> CPU cores are powergated, so we need to turn on the domains before we can bring
> the CPU cores online. Bringing secondary cores online happens early during the
> ssytem boot, so we call powergating initialization from platform early_init
> function.
> 
> Based on work by:
> 
> Scott Williams <scwilliams@nvidia.com>
> Colin Cross <ccross@android.com>
> Alex Frid <afrid@nvidia.com>
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

The series,

Acked-by: Stephen Warren <swarren@nvidia.com>

(I already saw this a few times before Peter posted it, so any concerns
I had have been fixed. Still, I'm not very familiar with this part of
the code, so it'd be awesome if e.g. Colin could review this too)

Tested-by: Stephen Warren <swarren@nvidia.com>

(Booted Tegra20 Harmony, validated 2 CPUs found in dmesg during boot,
validated top showed 2 CPUs being actively used. Booted Tegra30 Cardhu,
validated 4 CPUs found in dmesg during boot, but didn't validate anything
from user-space since the SD controller doesn't work yet and I don't have
an initrd set up to test with).

-- 
nvpublic

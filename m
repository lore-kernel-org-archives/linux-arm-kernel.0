From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 2 Feb 2012 10:04:12 -0800
Subject: [PATCH v2 8/8] ARM: tegra: support for secondary cores on Tegra30
In-Reply-To: <1328028051-24271-9-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E124AA5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, January 31, 2012 9:41 AM:
> Add support for bringing up secondary cores on Tegra30. On Tegra30 secondary
> CPU cores are powergated, so we need to turn on the domains before we can bring
> the CPU cores online. Bringing secondary cores online happens early during the
> sytem boot, so we call powergating initialization from platform early_init
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

Tested-by: Stephen Warren <swarren@nvidia.com>

This time, since I now have the SD card working, I managed to test real
user-space processes running on all 4 cores.

Note, patch 3 shouldn't compile due to a typo in a .size directive. It
does for me, so I could test this! But, it didn't for Olof. Aside from
that (which perhaps Olof would fixup during patch application?),

Acked-by: Stephen Warren <swarren@nvidia.com>

I also have a query on patch 3 about enabling coresight, but that's more
for my education than something that'd block patch application.

-- 
nvpublic

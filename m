From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 13:42:21 -0700
Subject: [PATCH] ARM: tegra: don't unlock MMIO access to DBGLAR
In-Reply-To: <1361268973-14584-1-git-send-email-josephl@nvidia.com>
References: <1361268973-14584-1-git-send-email-josephl@nvidia.com>
Message-ID: <5137AA2D.6000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 03:16 AM, Joseph Lo wrote:
> There is no need to unlock MMIO access to the DBGLAR all the time. Doing
> so may even cause problems if a SW bug causes writes to that MMIO region.
> 
> Cortex-A15 processors do not support the CP14 register write the code
> currently uses to unlock the DBGLAR; the instruction throws an undefined
> instruction exceptions. This prevents tegra_secondary_startup() from
> executing on Tegra114, and hence prevents SMP.
> 
> Remove the code that unlocks this access.

I have applied this to Tegra's for-3.10/fixes branch.

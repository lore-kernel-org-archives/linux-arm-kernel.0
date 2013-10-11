From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Oct 2013 12:40:13 -0600
Subject: [PATCH V2 0/4]
In-Reply-To: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
References: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
Message-ID: <5258460D.7060505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 03:58 AM, Joseph Lo wrote:
> This series adds the LP1 support for Tegra124. (suspend to LP2 also
> supported in this series)
> 
> Note:
> This patch series depends on the patch series below.
> * [PATCH 0/5] Tegra124 clock support
> * [PATCH V2 0/6] ARM: tegra: basic support for Tegra124 SoC
> * [PATCH] ARM: tegra: add clock properties for devices of Tegra124
> * [PATCH] ARM: tegra: enable Tegra RTC as default for Tegra124
> * [PATCH 0/4] ARM: tegra: add CPU hot-plug and idle support for Tegra124
> 
> Verified on Cardhu, Dalmore and Venice2 and with THUMB2_KERNEL as well.

I have applied patches 2-3 to Tegra's for-3.13/soc branch, and patch 4
to Tegra's for-3.13/dt branch.

I have not applied patch 1, since that's a clock driver change. Please
work with Mike and/or Peter to send that patch through the clock tree.
In general, if there aren't any compile-time or run-time dependencies
(for existing features, not new ones) between patches, patches for
different subsystems should be sent separately, rather than as a
combined series.

Note that "[PATCH] ARM: tegra: add clock properties for devices of
Tegra124" is not yet applied; I'm waiting for Peter's Tegra124 clock
series to be finalized before applying that. There's no compile-time
dependency here, and the patch only enables new features without
breaking existing ones, so there's no bisection issue here.

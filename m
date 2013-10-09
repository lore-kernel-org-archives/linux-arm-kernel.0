From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 17:12:19 -0600
Subject: [PATCH 1/7] clk: tegra124: add suspend/resume function for
 tegra_cpu_car_ops
In-Reply-To: <1381310411-11391-2-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-2-git-send-email-josephl@nvidia.com>
Message-ID: <5255E2D3.3040808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 03:20 AM, Joseph Lo wrote:
> Adding suspend/resume function for tegra_cpu_car_ops. We only save and
> restore the setting of the clock of CoreSight. Other clocks still need
> to be taken care by clock driver.

This series also mixes drivers/clk and arch/arm/mach-tegra changes. It
looks like there's no build-time dependency though, since this just
implements some extra hooks in tegra_cpu_car_ops, so I assume again this
clk patch will go through Mike's tree, and the rest of the patches
through the Tegra tree.

In the future, if there aren't any dependencies, it's best just to send
the two sets of changes separately.

Acked-by: Stephen Warren <swarren@nvidia.com>
(although it'd be nice to have Peter review it too)

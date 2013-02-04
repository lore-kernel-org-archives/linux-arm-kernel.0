From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Feb 2013 15:09:57 -0700
Subject: [PATCH] clocksource: tegra: move to of_clk_get
In-Reply-To: <1359985230-11506-1-git-send-email-pdeschrijver@nvidia.com>
References: <1359985230-11506-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <511031B5.4010900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 06:40 AM, Peter De Schrijver wrote:
> The new clockframework introduced DT IDs for each clock. To be able to remove
> the device registrations, this driver needs to be updated to use the DT IDs.
> Note that the actual removal of the clk_register_clkdev() calls will be done
> in a later series.

This seems fine for 3.10, but I wonder about dependencies. Will there be
a bunch of other similar changes? I guess this patch is a dependency of
some changes to drivers/clk/tegra/ to remove the non-DT clock
registrations? It'd be good to get a clear idea of all the dependencies,
so we can see what's the best tree to apply the changes to; perhaps this
should go through the drivers/clk tree, or Tegra's clk driver changes
need to go through the Tegra tree again in 3.10?

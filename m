From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 10:38:04 -0600
Subject: [PATCH 1/2] ARM: tegra: fix overflow in
 tegra20_pll_clk_round_rate()
In-Reply-To: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
References: <1347318758-7954-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F68EC.3050606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 05:12 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> 32-bit math isn't enough when e.g. *prate=12000000, and sel->n=1000.
> Use 64-bit math to prevent this.
> 
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I've applied the series to Tegra's for-3.7/common-clk branch, since both
patches fix issues triggered by the common clock conversion.

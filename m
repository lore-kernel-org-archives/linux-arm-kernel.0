From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 15:56:29 +0100
Subject: [PATCH 31/31] clk: tegra: remove bogus PCIE_XCLK
In-Reply-To: <1384548866-13141-32-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-32-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129145628.GK9712@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:26PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The "pcie_xclk" clock is not actually a clock at all, but rather a reset
> domain. Now that the custom Tegra module reset API has been removed, we
> can remove the definition of any "clocks" that existed solely to support
> it.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/clk/tegra/clk-tegra20.c         | 6 ------
>  drivers/clk/tegra/clk-tegra30.c         | 7 -------
>  include/dt-bindings/clock/tegra20-car.h | 2 +-
>  include/dt-bindings/clock/tegra30-car.h | 2 +-
>  4 files changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/c89c816d/attachment.sig>

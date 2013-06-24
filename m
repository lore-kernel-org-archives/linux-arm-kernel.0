From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 24 Jun 2013 14:07:19 -0700
Subject: [PATCH] clk: tegra: fix ifdef for tegra_periph_reset_assert inline
In-Reply-To: <1372100756-10448-1-git-send-email-swarren@wwwdotorg.org>
References: <1372100756-10448-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51C8B507.8020301@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/24/2013 12:05 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Commit 7064f6b "clk: tegra: provide tegra_periph_reset_assert
> alternative" added ifdef'd static inline versions of some functions,
> but tested ARCH_TEGRA rather than CONFIG_ARCH_TEGRA, thus disabling
> these function in all cases. In some cases, this caused HW modules to
> misbehave; for example, the Tegra I2C driver BUG()d during boot on
> Seaboard.
>
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Tested-by: Paul Walmsley <pwalmsley@nvidia.com> # for the Tegra30 Beaver
board

Stephen pointed me at this patch to fix the boot on Tegra30 Beaver boad
with linux-next 20130624.  Thanks Stephen!

- Paul

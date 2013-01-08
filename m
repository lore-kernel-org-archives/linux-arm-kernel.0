From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 15:52:49 -0700
Subject: [v2 2/9] HACK: ARM: tegra: Use CLK_IGNORE_UNUSED for Tegra 114 SoC
In-Reply-To: <1357649263-1098-3-git-send-email-hdoyu@nvidia.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
 <1357649263-1098-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <50ECA341.5020106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 05:47 AM, Hiroshi Doyu wrote:
> Use CLK_IGNORE_UNUSED for the Tegra 114 SoC to ensure
> clk_disable_unused() is not called. Otherwise the system will die,
> because the usecount of the clocks is incorrect. This patch will be
> reverted once the Tegra 114 clocks are implemented.

> diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c

Just as an FYI, I'll almost certainly apply Prashant's common clock
conversion before this series, so this patch will need some rework to be
applied on top of that.

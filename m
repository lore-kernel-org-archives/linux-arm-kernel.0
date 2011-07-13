From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 13 Jul 2011 20:00:58 +0200
Subject: [PATCH] ARM: Tegra: Trimslice: Tri-state DAP2 pinmux
In-Reply-To: <1310579091-7424-1-git-send-email-swarren@nvidia.com>
References: <1310579091-7424-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110713180058.GB27828@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> DAP2 is used for a bunch of GPIOs. Not tri-stating the pins means audio
> signals get sent out there, and this ends up resetting USB and breaking
> SDHCI too.
[...]
> diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
> index 82646a4..47c596c 100644
> --- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
> +++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
> @@ -35,7 +35,7 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
>  	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
>  	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
>  	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
> -	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
> +	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
                        ^^^^

The patch subject and description say that DAP2 is tristated, not DAP3.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/61ff604d/attachment.sig>

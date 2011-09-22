From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 22 Sep 2011 09:53:06 -0700
Subject: [PATCH 2/3] arm/tegra: add support for ventana pinmuxing
In-Reply-To: <1316686384-20236-3-git-send-email-pdeschrijver@nvidia.com>
References: <1316686384-20236-1-git-send-email-pdeschrijver@nvidia.com>
	<1316686384-20236-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1739554CD4@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, September 22, 2011 4:13 AM:
> Add support for ventana pinmuxing as a seaboard derivative. This is a cut down
> version of chromeos kernel commit 772f1b56e713be7a55759c2d5eadb9eb11d078db
> by Jong Kim <jongk@nvidia.com>.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Could you please repost these to the Tegra maintainers/lists as well.

> diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
...
> +static __initdata struct tegra_pingroup_config ventana_pinmux[] = {

The indentation of this new array uses a mix of spaces and TABs between
the fields. Probably best to consistently use one or the other. For
reference, the existing seaboard_pinmux[] uses just spaces internally.

> +	{TEGRA_PINGROUP_DAP3, TEGRA_MUX_DAP3,     TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
...
> +	{TEGRA_PINGROUP_DTA,  TEGRA_MUX_VI,       TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},

Finally, it's probably a good idea to add a patch to fix mach-tegra/Makefile
such that CONFIG_MACH_TEGRA_DT includes board-seaboard-pinmux.o. I know
internally I said it wasn't worth it since we'd be removing the pinmux
calls from board-dt.c soon, but I'm thinking now it'll take a little
while to sort that out, since I probably need to rework my patches for
that so they're implemented within the core pinmux subsystem rather than
separately within the Tegra pinmux driver. Sorry for flip-flopping here.

-- 
nvpublic

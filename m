From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 8 Aug 2011 09:57:52 -0700
Subject: [PATCH 4/5] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <76f31183766f1edce1230a925ced1c986dbdf028.1312742856.git.marvin24@gmx.de>
References: <cover.1312742856.git.marvin24@gmx.de>
	<76f31183766f1edce1230a925ced1c986dbdf028.1312742856.git.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F1721C1@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Sunday, August 07, 2011 1:01 PM:
> These clocks are required for usb operation.
...
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
...
> @@ -145,6 +145,11 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
>  	/* name		parent		rate		enabled */
>  	{ "uarta",	"pll_p",	216000000,	true },
>  	{ "uartd",	"pll_p",	216000000,	true },
> +
> +	{ "pll_a",      "pll_p_out1",   56448000,       true },
> +	{ "pll_a_out0", "pll_a",        11289600,       true },

Are you sure those two are required for USB operation; they're typically
used for audio. Of course, this might just be a bug in the commit
description:-) Although, if you are attempting to enable audio, there's
a bunch more stuff that'd need to be done, including some more clock
setup.

-- 
nvpublic

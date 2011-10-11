From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 11 Oct 2011 09:36:04 -0700
Subject: [PATCH v8 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <1318329909-32601-4-git-send-email-pdeschrijver@nvidia.com>
References: <1318329909-32601-1-git-send-email-pdeschrijver@nvidia.com>
	<1318329909-32601-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE19AB0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Tuesday, October 11, 2011 4:45 AM:
> Change-Id: I5ed18750e6a8aa3242dae4bcd7165cfd819356d2

You probably want to remove that.

...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
...
> +	if (i == ARRAY_SIZE(pinmux_configs))
> +		WARN(1, "Unknown platform! Pinmuxing not initialized\n");

Sorry to keep picking on this, but shouldn't that be simply:

		WARN(i == ARRAY_SIZE(pinmux_configs),
			"Unknown platform! Pinmuxing not initialized\n");

-- 
nvpublic

From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 11 Feb 2013 05:18:40 +0100
Subject: [PATCH 1/4] ARM: tegra: Unify tegra{20,30,114}_init_early()
In-Reply-To: <1828614.u7HcYf891a@ax5200p>
References: <2499199.srlLvkihNZ@ax5200p><51180121.6040803@wwwdotorg.org><1828614.u7HcYf891a@ax5200p>
Message-ID: <20130211.061840.516448986332629268.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Dietrich <marvin24@gmx.de> wrote @ Sun, 10 Feb 2013 22:16:14 +0100:

> ah, ok - I just skipped the "also" in your sentence above. But still, the 
> #ifdefs look strange to me and save only a few byte of code. Just me few 
> cents.

What about the following as Arnd suggested[1]?

void __init tegra_hotplug_init(void)
{
	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
	   return;
	   
	   if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC)) && tegra_chip_id == TEGRA20)
	      tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
	      if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC)) && tegra_chip_id == TEGRA30)
	      	 tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
}

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148632.html

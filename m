From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 26 Aug 2013 20:28:01 -0700
Subject: [PATCH 11/12] cpuidle: mvebu: Add initial cpu idle support for
 Armada 370/XP SoC
In-Reply-To: <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 23 Aug 2013 08:53:16 +0200")
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
 <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87d2oz7qym.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Add wfi/cpu idle/cpu deep idle power states support for Armada XP SoC.
>
> All the latencies and the power consumption values used at the
> "armada_370_xp_idle_driver" structure are preliminary and will be
> modified in the future after running some measurements and analysis.
>
> Based on the work of Nadav Haklai.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

> +int pm_support = WFI;
> +static int __init pm_enable_setup(char *str)
> +{
> +	if (!strncmp(str, "wfi", 3))
> +		pm_support = WFI;
> +	else if (!strncmp(str, "idle", 4))
> +		pm_support = MV_CPU_IDLE;
> +	else if (!strncmp(str, "deepidle", 6))
> +		pm_support = MV_CPU_DEEP_IDLE;
> +	else if (!strncmp(str, "off", 3))
> +		pm_support = DISABLED;
> +
> +	return 1;
> +}
> +__setup("pm_level=", pm_enable_setup);

Why is this new (but undocumented) kernel commandline needed when there
is already a way to configure the deepest C state from userspace?
(c.f. the 'disable' file under /sys/devices/system/cpu/cpuX/cpuidle/stateY)

Kevin

From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Mar 2013 23:31:26 +0100
Subject: IMX: board hardware macro
Message-ID: <515221BE.8050808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI all,

is there a macro to tell if the board is iMX51 and iMX6Q ?

I would like to do the same as:

static int __init tegra_cpuidle_init(void)
{
int ret;

switch (tegra_chip_id) {
case TEGRA20:
ret = tegra20_cpuidle_init();
break;
case TEGRA30:
ret = tegra30_cpuidle_init();
break;
case TEGRA114:
ret = tegra114_cpuidle_init();
break;
default:
ret = -ENODEV;
break;
}

return ret;
}
device_initcall(tegra_cpuidle_init);

Thanks in advance

-- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

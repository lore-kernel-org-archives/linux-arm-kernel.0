From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 May 2011 15:46:45 +0530
Subject: Tegra gpio driver: Need to configure pins in gpio mode/nontristate
	with  gpio-request
Message-ID: <96C9D994977DD0439FB6D3FE3B13DD906B1331B068@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
When working on gpio driver for tegra, I found that gpio_request() does not
make the corresponding soc pins to gpio mode. It still keeps the pins in SFIO mode.
So we need to call two extra function along with gpio_request():
Tegra_gpio_enable() and function for setting the pins in no non-tristate.

Sue to this, the gpio sysfs interface does not work properly from user space /sys/class/gpio/.
To make the pin in gpio mode fom user space, need to have changes in kernel.

I think the gpio_request() should make the pins to gpio mode and make ready for use.
Similarly gpio_free() should again put the pin into sfio mode with tristate disable.

Please comment if there is any better way..


Thanks,
Laxman

From: chunkeey@gmail.com (Christian Lamparter)
Date: Thu, 29 Mar 2018 16:05:47 +0200
Subject: [PATCH] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <5240033.8XEdSWCWGL@debian64>
References: <20180328180705.29147-1-chunkeey@gmail.com>
 <20180329002723.GD18510@minitux> <5240033.8XEdSWCWGL@debian64>
Message-ID: <3460672.7sj45fLQN6@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 29 Mar 2018 14:23:35 CEST Christian Lamparter wrote:
> Ok I see, I was aware of ACPI but not that a pinctrl-msm based driver is
> using it. Well, I thinks is possible to use is_acpi_device_node() or 
> !is_of_node() to detect whenever we are dealing with a OF or not:
> 
> would it be ok to do something like this?
> 
> |       if (!is_of_node(chip->of_node)) {
oops, this should be:
			if (!is_of_node(pctrl->dev->fwnode)) {
> |					/*
> |					 * (lengthy note about gpiochip_add_pin_range and OF with
> |					 * reference to Documentation/devicetree/bindings/gpio/gpio.txt
> |					 * - TBD)
> |					 */
> |					ret = gpiochip_add_pin_range(&pctrl->chip,
> |					[...]
> |		}

From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 03:22:25 -0700
Subject: [RFC PATCH v2 03/11] mfd: omap: control: core system control
 driver
In-Reply-To: <4FDF11C3.4010701@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11C3.4010701@dev.rtsoft.ru>
Message-ID: <20120620102224.GZ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> This patch introduces a MFD core device driver for
> OMAP system control module.
> 
> The control module allows software control of
> various static modes supported by the device. It is
> composed of two control submodules: general control
> module and device (padconfiguration) control
> module.

> +++ linux-2.6/drivers/mfd/omap-control-core.c
...


> +u32 omap_control_readl(u16 offset)
> +{
> +	return __raw_readl(omap_control_base + (offset));
> +}
> +
> +void omap_control_writel(u32 val, u16 offset)
> +{
> +	__raw_writel(val, omap_control_base + (offset));
> +}

There should not be any need to have the individual drivers use
these. Please instead just set up something where individual drivers
register with the control module core, and get their own iobase
returned so they can use readl/writel and behave like normal device
drivers.

Regards,

Tony

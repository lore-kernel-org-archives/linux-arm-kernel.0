From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2012 14:21:40 +0000
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
Message-ID: <201206291421.40717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 June 2012, Qiao Zhou wrote:
> +       ret =
> +           regmap_add_irq_chip(chip->regmap, chip->irq, flags, chip->irq_base,
> +                               chip->regmap_irq_chip, &chip->irq_data);

One more question I have about this, mainly for Mark:

I understand that by passing -1 into regmap_add_irq_chip, it should allocate
its own linear irq domain rather using a legacy domain. Does that require
any other changes? Should the drivers that use the irq number just use
regmap_irq_get_virq() to get the linux irq number, or is there more to do
here?

	Arnd

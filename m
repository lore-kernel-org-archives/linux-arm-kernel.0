From: davem@davemloft.net (David Miller)
Date: Sun, 24 Apr 2016 14:18:06 -0400 (EDT)
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160424.141806.786009616301278103.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>
Date: Thu, 21 Apr 2016 14:48:38 +0530

> +struct shared_mdio_master *shared_mdio_alloc_master(struct device *parent,
> +						    struct device_node *node)
> +{
> +	int ret = 0;
> +	struct shared_mdio_master *master;

Always order local variable declarations in reverse christmas tree
(longest to shortest line) order.

> +static int shared_mdio_driver_probe(struct device *dev)
> +{
> +	int rc;
> +	struct shared_mdio_master *master = to_shared_mdio_master(dev);
> +	struct shared_mdio_driver *drv = to_shared_mdio_driver(dev->driver);

Likewise.

Please audit your entire submission for this issue.

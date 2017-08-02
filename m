From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Aug 2017 16:16:38 +0200
Subject: [patch v1 1/2] drivers: jtag: Add JTAG core driver
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170802141638.GC25781@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void jtag_unregister(struct jtag *jtag)
> +{
> +	struct device *dev = jtag->dev;
> +
> +	mutex_lock(&jtag_mutex);
> +	list_add_tail(&jtag->list, &jtag_list);

add?

> +	mutex_unlock(&jtag_mutex);
> +	cdev_del(&jtag->cdev);
> +	device_unregister(dev);
> +	ida_simple_remove(&jtag_ida, jtag->id);
> +}

  Andrew

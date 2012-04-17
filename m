From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 13:40:06 +0000
Subject: [PATCH v3 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <1334666424-2277-1-git-send-email-stigge@antcom.de>
References: <1334666424-2277-1-git-send-email-stigge@antcom.de>
Message-ID: <201204171340.06788.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Roland Stigge wrote:
> +static int match(struct device *dev, void *data)
> +{
> +       struct device_node *node = (struct device_node *)data;
> +       return dev->of_node == node ? 1 : 0;
> +}

One small correction: you should probably check if the device
is actually bound to isp1301_driver:

	return (dev->of_node == node) && (dev->driver == &isp1301_driver.driver);

Otherwise, the changes from last version look all good.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 May 2012 18:43:51 +0000
Subject: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
In-Reply-To: <1338375394-16268-1-git-send-email-kishon@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
Message-ID: <201205301843.51568.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 May 2012, Kishon Vijay Abraham I wrote:
> 
> This patch series is done as a preparatory step for adding phy drivers
> for dwc3 and musb.
> 
> This series adds a new driver for ocp2scp to which phy drivers are connected.
> 
> I'm planning to send phy drivers asap. Meanwhile I'd like to get some
> review comments for this series. I have also plans to send device tree
> adaptation of the ocp2scp driver.
> 
> Developed on
> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next
> 
> If it has to be based on some other tree, please let me know.

This must be the most pointless driver I've seen in a long time. It doesn't
actually do anything at all, it just creates child devices from a static
lookup table.

Just put the devices you actually want into the device tree instead and
have them automatically created.

	Arnd

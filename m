From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 12 Apr 2013 15:30:57 +0200
Subject: [PATCH] SPI: spidev: Add DT compatible string for spidev driver.
In-Reply-To: <20130412125621.9645.78102.stgit@localhost>
References: <20130412125621.9645.78102.stgit@localhost>
Message-ID: <51680C91.6030005@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Le 12/04/2013 14:56, Martin Fuzzey a ?crit :
> The spidev driver is useful to allow userspace access
> to SPI devices that have no kernel SPI driver.
> 
> However DT requires a compatible tree to allow the driver
> to be probed.
> 
> To avoid having to modify the driver for every extra device
> add a generic "linux,spidev" compatible string that may be
> used in the DT to match such devices.

I submitted a similar patch quite some time ago [1], and at the time,
this patch was found inadequate, and we decided to add the compatible of
the particular device that we drive through spidev.

The rationale behind that is that the device tree is a hardware
description, so it's only interested about which device there is on the
SPI bus, and not the driver that will eventually handle it. That allows
both to have a meaningful devicetree, but also to easily handle the case
where a driver for that particular device is finally implemented, since
we won't have to change the device tree in itself to reflect this.

So I suggest you only add to the "real" compatible string instead of a
generic one.

Maxime

[1] http://comments.gmane.org/gmane.linux.kernel.spi.devel/11734

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

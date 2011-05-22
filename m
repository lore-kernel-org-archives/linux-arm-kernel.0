From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 May 2011 12:03:03 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
Message-ID: <201105221203.03970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 May 2011 19:42:34 Grant Likely wrote:
> 1) drop amba-bus entirely and use platform_device everywhere, similar
> to what OMAP has done
> 2) strictly create amba_devices for nodes compatible with "arm,amba-device"
> 3) be intelligent about amba device creation; create an amba_device
> only for devices we know are driven with amba_driver.

Or maybe

4) Use amba_device for all devices on an amba bus (identified by
the compatible property of the bus), but mark the ones that do
not have primecell compatible registers so that the amba bus
does not try to look at them but instead takes the information
from the device tree.

Even though this might seem a bit silly when most devices are
not primecell ones, but it could be used as an incentive for
hardware designers (I can dream, right?) to provide them in future
designs. It would also make it easier to document the actual bus
hierarchy correctly.

	Arnd

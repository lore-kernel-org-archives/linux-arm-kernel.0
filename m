From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Aug 2014 14:40:53 +0100
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
In-Reply-To: <53E0DB92.2030609@freescale.com>
References: <53E0DB92.2030609@freescale.com>
Message-ID: <20140805134053.GJ18780@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 02:26:42PM +0100, Arnab Basu wrote:
> Hi

Hi Arnab,

> While trying to boot Linux with an initrd I found that 
> CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64 
> defconfig. Is this because no one has got around to adding them or is 
> this something that has been omitted on purpose?

Do we really want CONFIG_BLK_DEV_RAM=y by default? The Kconfig text for the
options says:

	Most normal users won't need the RAM disk functionality, and can
	thus say N here.

so I'd be inclined to say we should leave things as they are. The current
defconfig is largely driven by our testing efforts, but I've been enabling
other options that could benefit many people without hindering others (e.g.
DEVTMPFS_MOUNT).

Will

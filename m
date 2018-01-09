From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jan 2018 14:47:53 +0000
Subject: [PATCH] ARM: locomo: fix free dev incorrectly
In-Reply-To: <20180109143755.16931-1-sxwjean@me.com>
References: <20180109143755.16931-1-sxwjean@me.com>
Message-ID: <20180109144753.GJ17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 10:37:55PM +0800, Xiongwei Song wrote:
> In function locomo_init_one_child, If kzalloc call is failed for dev we
> would goto out label, then call kfree for dev, however, dev is NULL, we
> shouldn't do this.

kfree() internally checks for NULL pointers so callers don't have to.
Your patch is not necessary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

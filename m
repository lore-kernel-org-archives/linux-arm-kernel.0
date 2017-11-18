From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Nov 2017 08:17:49 +0000
Subject: [PATCH 1/5 v2] ASoC: ep93xx-ac97: Fix platform_get_irq's error
 checking
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171118081749.GS31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 10:57:51AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.

IRQ 0 is not a valid interrupt.  The correct test here is <= 0.
Please rework your patches for this.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

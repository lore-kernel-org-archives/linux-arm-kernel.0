From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Nov 2017 08:18:25 +0000
Subject: [PATCH 3/5 v2] ASoC: nuc900: Fix platform_get_irq's error checking
In-Reply-To: <19f8c64a4720118a6d6c4fedd5f8defa6938d1db.1510982440.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
 <19f8c64a4720118a6d6c4fedd5f8defa6938d1db.1510982440.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171118081825.GU31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 10:57:53AM +0530, Arvind Yadav wrote:
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

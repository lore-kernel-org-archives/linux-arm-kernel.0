From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Nov 2017 08:15:40 +0000
Subject: [PATCH 0/3] mfd: Handle platform_get_irq's error checking and
 return
In-Reply-To: <1510986993-4936-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510986993-4936-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20171118081540.GQ31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 12:06:30PM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct and we must check its return value.

The failure case is <= 0, not < 0.  IRQ0 is not valid.  Please rework
your patches to that effect, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

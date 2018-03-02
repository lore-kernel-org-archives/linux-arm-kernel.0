From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 12:34:44 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302122655.uckejonjyzt4vjd3@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
 <20180302121929.GY9418@n2100.armlinux.org.uk>
 <20180302122655.uckejonjyzt4vjd3@mwanda>
Message-ID: <20180302123444.GZ9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 03:26:56PM +0300, Dan Carpenter wrote:
> Ok, but in that case the original code is still wrong because it returns
> early with success.  I guess it could be changed to:
> 
> 	if (irq <= 0)
> 		return -ENXIO;

What if platform_get_irq() returns -EPROBE_DEFER or some other error
code?

So we're now re-hashing all the discussion from last November.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 8 Jul 2016 11:11:23 -0700
Subject: [PATCH v2 3/6] net: ethernet: bgmac: move BCMA MDIO Phy code into
 a separate file
In-Reply-To: <1467932938-21819-4-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-4-git-send-email-jon.mason@broadcom.com>
Message-ID: <577FECCB.9050007@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:08 PM, Jon Mason wrote:
> Move the BCMA MDIO phy into a separate file, as it is very tightly
> coupled with the BCMA bus.  This will help with the upcoming BCMA
> removal from the bgmac driver.  Optimally, this should be moved into
> phy drivers, but it is too tightly coupled with the bgmac driver to
> effectively move it without more changes to the driver.
> 
> Note: the phy_reset was intentionally removed, as the mdio phy subsystem
> automatically resets the phy if a reset function pointer is present.  In
> addition to the moving of the driver, this reset function is added.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 16:22:17 +0000
Subject: [GIT PULL] musb regression fixes for v3.7-rc4
In-Reply-To: <20121109223939.GZ6801@atomide.com>
References: <20121109223939.GZ6801@atomide.com>
Message-ID: <201211121622.17616.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 November 2012, Tony Lindgren wrote:
> This series fixes an annoying regression to make MUSB working
> on omap4 again. Although it's getting rather late for these
> changes for the -rc cycle, it is important as many devices
> are using MUSB for charging and connectivity.
> 
> With the USB PHY changes, MUSB started using the newly added
> drivers/usb/phy/omap-usb2.c driver introduced by commit
> 657b306a (usb: phy: add a new driver for omap usb2 phy)
> that is using the newly introduced drivers/bus/omap-ocp2scp.c
> introduced by commit 26a84b3e (drivers: bus: add a new driver
> for omap-ocp2scp).
> 
> These changes allowed dropping a lot of PHY related code from
> arch/arm/mach-omap2/omap_phy_internal.c and have it live in
> the device driver like it should with commit c9e4412a (arm: omap:
> phy: remove unused functions from omap-phy-internal.c).
> 
> However, MUSB on omap4 broke with these changes for legacy
> platform data boot, and now only works with device tree for
> omap4. Unfortunately we are still few critical bindings away
> from being able to make omap4 usbale with device tree.
> 
> Fix the regression properly by adding platform data support
> to the ocp2scp driver so we can avoid adding back the driver
> code to arch/arm/mach-omap2.
> 

Applied to fixes branch, will send this soon.

	Arnd

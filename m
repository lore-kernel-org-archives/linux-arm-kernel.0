From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 10:09:27 +0100
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140407042334.GA28025@dragon>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <20140407042334.GA28025@dragon>
Message-ID: <20140407090927.GW7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 12:23:37PM +0800, Shawn Guo wrote:
> And I see another HDMI regression with my testing on mainline kernel.  I
> can have my HDMI work at 1920x1080 with v3.14 kernel, but it can only
> probes 1024x768 with the mainline today.

Works for me here.

> [    20.606] (II) LoadModule: "modesetting"
> [    20.607] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
> [    20.609] (II) Module modesetting: vendor="X.Org Foundation"
> [    20.609] 	compiled for 1.12.1.902, module version = 0.3.0
> [    20.610] 	Module class: X.Org Video Driver
> [    20.610] 	ABI class: X.Org Video Driver, version 12.0
> [    20.610] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
> [    20.610] (++) using VT number 7
> 
> [    20.624] (WW) Falling back to old probe method for modesetting
> [    20.624] (II) modesetting(0): using default device
> [    20.627] (II) modesetting(0): Creating default Display subsection in Screen section
> 	"Default Screen Section" for depth/fbbpp 24/32
> [    20.627] (==) modesetting(0): Depth 24, (==) framebuffer bpp 32
> [    20.628] (==) modesetting(0): RGB weight 888
> [    20.628] (==) modesetting(0): Default visual is TrueColor
> [    20.628] (II) modesetting(0): ShadowFB: preferred NO, enabled NO
> [    20.628] (II) modesetting(0): Output HDMI-0 has no monitor section
> [    20.629] (II) modesetting(0): EDID for output HDMI-0
> [    20.629] (II) modesetting(0): Printing probed modes for output HDMI-0

So no EDID.  Did you update the "ddc" property to "ddc-i2c-bus" ?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

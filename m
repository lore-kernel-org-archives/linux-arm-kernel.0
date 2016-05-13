From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 May 2016 11:44:37 +0100
Subject: imx-drm: regression due to commit 503fe87bd0a8 ("gpu: ipu-v3:
 Fix imx-ipuv3-crtc module autoloading")
In-Reply-To: <20160513123336.6996dd89@ipc1.ka-ro>
References: <20160513123336.6996dd89@ipc1.ka-ro>
Message-ID: <20160513104437.GT19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 12:33:36PM +0200, Lothar Wa?mann wrote:
> I'm always very suspicious when seeing code moving of_node's from
> one device to another or assigning of_node's to platform devices that
> weren't instantiated via DT.

It's completely wrong to add an of_node to a device on the same bus
that already has a device with the same of_node - doing so means
that the bus matching code will match the same device driver to both
devices, which may not be what you want to happen.

Just don't do it, it's a bug waiting to happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

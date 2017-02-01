From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 10:53:10 +0000
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <1485945751.3353.28.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1485870854.2932.63.camel@pengutronix.de>
 <5586b893-bf5c-6133-0789-ccce60626b86@gmail.com>
 <1485941457.3353.13.camel@pengutronix.de>
 <20170201101111.GL27312@n2100.armlinux.org.uk>
 <1485945751.3353.28.camel@pengutronix.de>
Message-ID: <20170201105310.GN27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 11:42:31AM +0100, Philipp Zabel wrote:
> On Wed, 2017-02-01 at 10:11 +0000, Russell King - ARM Linux wrote:
> Right, it's just that in the latest version there is no v4l2_subdev for
> fifos and idmac. There is the capture interface entity that represents
> one of the IDMAC write channels, but that doesn't have a pad and format
> configuration.
> The SMFC entity was removed because the fifo can be considered part of
> the link between CSI and IDMAC. There is no manual configuration
> necessary as the SMFC itself can't do anything to the data that flows
> through it. There is no reason to present it to userspace as a no-op
> entity.
> So in the direct CSI -> SMFC -> IDMAC case, the CSI source pad now is
> the nearest neighbor pad to the IDMAC capture video device.

Ok, that sounds fine then.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

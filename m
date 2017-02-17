From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2017 11:06:16 +0000
Subject: [PATCH v4 23/36] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <1487328479.3107.21.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-24-git-send-email-steve_longerbeam@mentor.com>
 <1487328479.3107.21.camel@pengutronix.de>
Message-ID: <20170217110616.GD21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:47:59AM +0100, Philipp Zabel wrote:
> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> > +static void csi2_dphy_init(struct csi2_dev *csi2)
> > +{
> > +	/*
> > +	 * FIXME: 0x14 is derived from a fixed D-PHY reference
> > +	 * clock from the HSI_TX PLL, and a fixed target lane max
> > +	 * bandwidth of 300 Mbps. This value should be derived
> 
> If the table in https://community.nxp.com/docs/DOC-94312 is correct,
> this should be 850 Mbps. Where does this 300 Mbps value come from?

I thought you had some code to compute the correct value, although
I guess we've lost the ability to know how fast the sensor is going
to drive the link.

Note that the IMX219 currently drives the data lanes at 912Mbps almost
exclusively, as I've yet to finish working out how to derive the PLL
parameters.  (I have something that works, but it currently takes on
the order of 100k iterations to derive the parameters.  gcd() doesn't
help you in this instance.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

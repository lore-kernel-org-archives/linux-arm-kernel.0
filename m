From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 6 Jul 2011 16:26:26 -0700
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <20110706185546.GJ4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
	<20110706185546.GJ4871@ponder.secretlab.ca>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Wednesday, July 06, 2011 12:56 PM:
> On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wrote:
> > Add I2C and it's child device nodes for beagle board.
> > The I2C1 controller child devices are not populated and it
> > should be handled along with OMAP clock changes.
...
> > diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
...
> > +	i2c at 48070000 {
...
> > +		clock-frequency = <2600>;
> > +		status = "disabled";
> 
> Drop 'status' when you move this node definition to
> arch/arm/boot/dts/omap3.dtsi.  Board overlay files that include the
> omap3.dtsi should explicitly disable any devices that it does not use
> (which is opposite to what tegra currently does, but I'm going to
> change that).

Purely out of idle curiosity: What's the benefit of one way over the other?

-- 
nvpublic

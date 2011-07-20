From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jul 2011 17:03:55 +0100
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
References: <20110719234158.2779.15394.stgit@ponder>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
Message-ID: <20110720160355.GB2406@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 08:37:19AM -0700, Stephen Warren wrote:
> Grant Likely wrote at Tuesday, July 19, 2011 5:43 PM:

> > +	sound {
> > +		compatible = "nvidia,harmony-sound", "nvidia,tegra-wm8903";

> I thought the sound bindings were still somewhat experimental and not
> completely agreed upon. One issue I see is that Device Tree is
> supposed to represent pure HW, rather than driver-required abstractions,
> and at least the compatible name here is pretty Linux-driver-specific.

The current decision is that the schematic for embedded audio hardware
is sufficiently interesting to be considered hardware in its own right
separately to the chips contained within it.  

> > +		spkr-en-gpios = <&codec 2 0>;

> Should that be "gpio" not "gpios", since there is only one?

There's only one in this board but one does see designs with separate
left and right channel enables sometimes, or separate front and back
speaker enables for phones.

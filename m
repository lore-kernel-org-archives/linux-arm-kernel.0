From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 21 Jul 2011 06:49:11 +0800
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
References: <20110719234158.2779.15394.stgit@ponder>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
Message-ID: <20110720224910.GI6999@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 08:37:19AM -0700, Stephen Warren wrote:
> Grant Likely wrote at Tuesday, July 19, 2011 5:43 PM:
> > Everything required to populate NVIDIA Tegra devices from the device
> > tree.  This patch adds a new DT_MACHINE_DESC() which matches against
> > a tegra20 device tree.  So far it only registers the on-chip devices,
> > but it will be refined in follow on patches to configure clocks and
> > pin IO from the device tree also.
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> > Hi all,
> > 
> > Similar to the versatile patch I just posted, this is certainly not
> > complete board support, but it is enough to be useful.  I'd like to
> > merge this for v3.1.  It should not break any existing board support.
> 
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> 
> tegra-*.dts don't include status="disable" for all the unused controllers.
> Should that be added?
> 
> > +	sound {
> > +		compatible = "nvidia,harmony-sound", "nvidia,tegra-wm8903";
> 
> I thought the sound bindings were still somewhat experimental and not
> completely agreed upon. One issue I see is that Device Tree is
> supposed to represent pure HW, rather than driver-required abstractions,
> and at least the compatible name here is pretty Linux-driver-specific.
> 
> I think there are some devices missing from the DT file for audio too,
> e.g. the ALSA "PCM" (DMA) driver.
> 
> Also, the bindings for this aren't documented IIRC.
> 
> I'd suggest dropping the audio part of the DT file until the audio side
> is more mature.
> 
> > +		spkr-en-gpios = <&codec 2 0>;
> 
> Should that be "gpio" not "gpios", since there is only one?
> 
My reason for using "gpios" over "gpio" is that
Documentation/devicetree/bindings/gpio/gpio.txt says so.  Unless you
want to change the document to elaborate the difference between "gpio"
and "gpios", which I do not see the necessity ...

GPIO properties should be named "[<name>-]gpios".

Regards,
Shawn

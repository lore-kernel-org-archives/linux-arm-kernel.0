From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 20:18:07 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <201303211903.52383.arnd@arndb.de>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <514B4A79.1070501@gmail.com> <201303211903.52383.arnd@arndb.de>
Message-ID: <20130321201807.7cb04978@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 21 Mar 2013 19:03:52 +0000, Arnd Bergmann wrote:
> On Thursday 21 March 2013, Rob Herring wrote:
> > >       soc {
> > > -             #address-cells = <1>;
> > > -             #size-cells = <1>;
> > > +             #address-cells = <2>;
> > > +             #size-cells = <2>;
> > 
> > If all the addresses for the soc bus are below 4GB or even within a 4GB
> > range if using the ranges property, then changing all this and
> > everything below it is kind of pointless.
> 
> Good point. We'll probably also have to change it all again when we add a new
> binding for that bus in 3.10, so it makes sense to change it only once.

In the mean time can we do something like:

	soc {
		compatible = "simple-bus";
		range = <...>;

		[... all the peripherals ...]
	};

with the range = <...> property converting the peripheral registers
base address (expressed as offsets in the reg = <...> properties of the
subnodes) into the absolute physical address?

I'm planning to work on the DT binding for the mvebu-mbus driver as
soon as the PCIe driver gets accepted, but it would be good to have an
intermediate solution to get the LPAE support in.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

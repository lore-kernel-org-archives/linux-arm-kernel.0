From: mailinglists@kunz-im-inter.net (Frank Kunz)
Date: Fri, 03 Nov 2017 13:01:12 +0100
Subject: [PATCH] ARM: sun7i: Add Cubietech Einstein A20 board device-tree
In-Reply-To: <20171103084427.rba6zc333fawbrv4@flea>
References: <20171102143534.19353-1-mailinglists@kunz-im-inter.net>
 <4661874.z7VF5iD9hg@donald> <20171103084427.rba6zc333fawbrv4@flea>
Message-ID: <5111393.hsQMvIb64U@donald>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. November 2017, 09:44:27 CET schrieb Maxime Ripard:
> Hi Frank,
> 
> On Thu, Nov 02, 2017 at 07:59:04PM +0100, Frank Kunz wrote:
> > > > +&mmc2 {
> > > > +	pinctrl-names = "default";
> > > > +	pinctrl-0 = <&mmc2_pins_a>;
> > > > +	vmmc-supply = <&reg_vcc3v3>;
> > > 
> > > What regulator is this connected to on the PMIC?
> > 
> > Fixed, On the schematic it is finally connected to 3v0.
> 
> Sorry, it wasn't really what I meant. Surely there's a PMIC regulator
> providing that 3.0V, you should put that regulator here.
> 

It is not connected to any of the PMIC (AXP209) regulators. There is a 
dedicated DCDC converter on that board which is driven by IPSOUT. This one 
generates the 3.0V IO supply.

Br,
Frank

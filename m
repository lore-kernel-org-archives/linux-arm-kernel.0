From: robh@kernel.org (Rob Herring)
Date: Wed, 17 Oct 2018 14:32:18 -0500
Subject: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <20181012170002.GJ2340@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
 <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
 <20181012170002.GJ2340@sirena.org.uk>
Message-ID: <20181017193218.GA8853@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 07:00:02PM +0200, Mark Brown wrote:
> On Thu, Oct 11, 2018 at 07:59:15PM +0200, Lubomir Rintel wrote:
> > On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:
> 
> > > Please use subject lines matching the style for the subsystem.  This
> > > makes it easier for people to identify relevant patches.
> 
> > Thanks for the response.
> 
> > I'm a little confused here. Why I chose this subject line is because I
> > did this:
> 
> >   git log --no-merges Documentation/devicetree/bindings/
> 
> Try Documentation/devicetree/bindings/spi instead :)

Just so you know, pretty much everything else except SPI, regulators, 
and ASoC follows 'dt-bindings: <binding dir>:' these days.

I don't really care so much about the difference, but it is tribal 
knowledge that submitters have to learn. 

Really, this could all be solved with tooling using MAINTAINERS and 
get_maintainers.pl, but limping around in checkpatch.pl occasionally is 
enough perl for me.

> > to figure out what's the typical subject for the DT binding changes.
> 
> > I also believed that's the right way to get Rob Herring's and Mark
> > Rutland's attention. 

All that matters is CC'ing the DT list really. And Mark R is pretty much
AWOL. Reviewing bindings in front of your own will get yours reviewed 
faster. :)

> Do the device tree binding documentation typically
> 
> There *is* some debate for the DT bindings unfortunately.
> 
> > go in with the associated drivers, or via their tree ("OPEN FIRMWARE
> > AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?
> 
> They usually go in with the drivers.  This one isn't so bad since it
> does mention SPI, it's a worse problem when that's not present at all.

Right.

I generally only take single patches not in a series with dts or driver 
changes and when/if the subsystem maintainer doesn't pick them up. Or 
any standalone fixes I'll take.

Rob

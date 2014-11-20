From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 08:35:43 +0100
Subject: [PATCHv4 01/10] arm: mvebu: fix vendor prefix typo in
 kirkwood-synology.dtsi
In-Reply-To: <20141120050213.GB2596@lunn.ch>
References: <cover.1416351425.git.arno@natisbad.org>
 <20141120015519.GA22670@titan.lakedaemon.net> <20141120050213.GB2596@lunn.ch>
Message-ID: <7770322.bXz9M2IL1d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 06:02:13 Andrew Lunn wrote:
> On Wed, Nov 19, 2014 at 08:55:19PM -0500, Jason Cooper wrote:
> > Andrew,
> > 
> > On Wed, Nov 19, 2014 at 12:01:36AM +0100, Arnaud Ebalard wrote:
> > > 
> > > As reported by Andrew, the vendor prefix for Seiko Instruments, Inc.
> > > S-35390A I2C RTC chip in kirkwood-synology.dtsi has a typo (ssi
> > > instead of sii). This patches fixes it.
> > > 
> > > Reported-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> > > ---
> > >  arch/arm/boot/dts/kirkwood-synology.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
> > > index 811e0971fc58..8be5b2e4626e 100644
> > > --- a/arch/arm/boot/dts/kirkwood-synology.dtsi
> > > +++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
> > > @@ -266,7 +266,7 @@
> > >  
> > >                     s35390a: s35390a at 30 {
> > >                             status = "disabled";
> > > -                           compatible = "ssi,s35390a";
> > > +                           compatible = "sii,s35390a";
> > 
> > Should the driver now support both variants for backward compatibility?
> 
> Hi Jason
> 
> This is an i2c device. i2c totally ignores the vendor. It is optional.
> So there is no backward compatibility issues.
> 

This question keeps coming up, so I'd suggest explaining it in the
patch changelog.

	Arnd

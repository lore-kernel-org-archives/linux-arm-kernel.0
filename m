From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Mar 2014 10:28:54 +0100
Subject: [PATCH 3/3] ARM: Kirkwood: DT: Add missing vendor prefix
In-Reply-To: <20140304030522.GZ1872@titan.lakedaemon.net>
References: <1393773855-9592-1-git-send-email-andrew@lunn.ch>
 <1393773855-9592-3-git-send-email-andrew@lunn.ch>
 <20140304030522.GZ1872@titan.lakedaemon.net>
Message-ID: <20140304092854.GI16655@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 10:05:22PM -0500, Jason Cooper wrote:
> Andrew,
> 
> Couple of stupid questions:
> 
>  - I haven't seen 0/1 nor 1/1 show up anywhere (dt, lakml, inbox), am I
>    missing something?

Humm, i will check, and do a resend if needed.

 
> On Sun, Mar 02, 2014 at 04:24:15PM +0100, Andrew Lunn wrote:
> > Add vendor prefixes to compatible strings where they are missing.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/boot/dts/kirkwood-b3.dts              | 2 +-
> >  arch/arm/boot/dts/kirkwood-cloudbox.dts        | 2 +-
> >  arch/arm/boot/dts/kirkwood-dreamplug.dts       | 2 +-
> >  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
> >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi     | 2 +-
> >  arch/arm/boot/dts/kirkwood-nsa310.dts          | 2 +-
> >  arch/arm/boot/dts/kirkwood-nsa310a.dts         | 2 +-
> >  arch/arm/boot/dts/kirkwood-openblocks_a6.dts   | 2 +-
> >  arch/arm/boot/dts/kirkwood-openblocks_a7.dts   | 2 +-
> >  9 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
> > index 40791053106b..6becedebaa4e 100644
> > --- a/arch/arm/boot/dts/kirkwood-b3.dts
> > +++ b/arch/arm/boot/dts/kirkwood-b3.dts
> > @@ -75,7 +75,7 @@
> >  			m25p16 at 0 {
> >  				#address-cells = <1>;
> >  				#size-cells = <1>;
> > -				compatible = "m25p16";
> > +				compatible = "st,m25p16";
> 
> Have you checked that the drivers for each of these changes already
> support the new compatible strings?

I2c and MTD ignore the vendor string when performing matches. However,
checkpatch.pl does not. It is also technically correct to have a
vendor string.

       Andrew

From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Dec 2013 21:59:28 +0100
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20131228170114.GH19878@titan.lakedaemon.net>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
Message-ID: <20131228205928.GB19850@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 28, 2013 at 12:01:14PM -0500, Jason Cooper wrote:
> Hi Andrew,
> 
> On Sat, Dec 28, 2013 at 05:12:11PM +0100, Andrew Lunn wrote:
> > The Excito Bubba B3 is a home server, single driver NAS box, Wifi
> 
> nit, s/driver/drive/

Upps. Thanks
> 
> > + * Note: This requires a new'ish version of u-boot, which disables the
> > + * L2 cache. If your B3 silently fails to boot, u-boot is probably too
> > + * old. Either upgrade, or consider the following email:
> > + *
> > + * http://lists.debian.org/debian-arm/2012/08/msg00128.html
> 
> Nice, thanks for adding this.

Yes, i was bashing my head against a brick wall before i went googling
and found this.

> > +	ocp at f1000000 {
> 
> I plan on going though and sorting the nodes under the ocp bus for all
> the dts files during the next cycle.  Would you mind sorting these so we
> have one less to worry about?

Sure. Sort on what? Address, alphabetic on node name?

> > +		i2c at 11000 {
> > +			status = "okay";
> > +			/*
> > +			 * There is something on the bus at address 0x64.
> > +			 * Not yet identified what it is, maybe the eeprom
> > +			 * for the Atheros WiFi chip?
> > +			 */
> 
> Not related to accepting this patch, have you found anything in the
> stock kernel?

There is noting in the vendor kernel. I asked Excito about this maybe
two years ago. The guy who answered said there is no i2c device on the
base board, but i2c does go to the wifi module, hence the assumption
given above.

> 
> > +		};
> > +
> > +		serial at 12000 {
> > +			/* Internal on test pins, 3.3v TTL */
> 
> Do you have a pointer to a pin layout?

Yes, i can add a URL to an Excito forum page. They are friendly about
this, document it themselves.
 
> > +		programming_led {
> > +			label = "bubba3:green:programming";
> > +			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "default-off";
> 
> Perhaps we can use 'default-state = "off";' here to avoid the
> linux-specific property?

Sure.

v2 in the next day or two.

   Andrew

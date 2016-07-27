From: stefan.mavrodiev@gmail.com (stefan.mavrodiev at gmail.com)
Date: Wed, 27 Jul 2016 13:02:41 +0300
Subject: [PATCH v4] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <20160727062146.GA6560@lukather>
References: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
 <30014119.IrjfP0xFry@linux-cigu> <20160727062146.GA6560@lukather>
Message-ID: <1604486.mrBvLz4HRZ@linux-cigu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 27, 2016 8:21:46 AM EEST Maxime Ripard wrote:
> On Wed, Jul 27, 2016 at 08:12:29AM +0300, stefan.mavrodiev at gmail.com wrote:
> > > > +&reg_dcdc1 {
> > > > +	regulator-always-on;
> > > > +	regulator-min-microvolt = <3300000>;
> > > > +	regulator-max-microvolt = <3300000>;
> > > > +	regulator-name = "vcc-dsi";
> > > > +};
> > > 
> > > What is it used for? Is it really necessary to keep it on at all time?
> > 
> > I think so.
> > This is the supply for the MMC.
> 
> Then it's poorly named, and you should tie it to the MMC, and remove
> the always-on if it's only used by the mmc. always-on is supposed to
> be for regulators that shouldn't but turned off for the system to stay
> running. Some MMC regulator doesn't fit that description.
> 
It's named upon the A33 power pin - "VCC-DSI". 
If I remove "always-on" the board still will work, since dcdc1 is tied to 
mmc0. 
vmmc-supply = <&reg_dcdc1>;

We assume this voltage will be always present and there are some pullups that 
are tied to it (on i2c0 and i2c1 bus).  In this case should I remove "always-
on" from the regulator node?

> Maxime

Best regards,
Stefan Mavrodiev

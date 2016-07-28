From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 19:53:30 +0200
Subject: [PATCH v4] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <1604486.mrBvLz4HRZ@linux-cigu>
References: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
 <30014119.IrjfP0xFry@linux-cigu> <20160727062146.GA6560@lukather>
 <1604486.mrBvLz4HRZ@linux-cigu>
Message-ID: <20160728175330.GC6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 01:02:41PM +0300, stefan.mavrodiev at gmail.com wrote:
> On Wednesday, July 27, 2016 8:21:46 AM EEST Maxime Ripard wrote:
> > On Wed, Jul 27, 2016 at 08:12:29AM +0300, stefan.mavrodiev at gmail.com wrote:
> > > > > +&reg_dcdc1 {
> > > > > +	regulator-always-on;
> > > > > +	regulator-min-microvolt = <3300000>;
> > > > > +	regulator-max-microvolt = <3300000>;
> > > > > +	regulator-name = "vcc-dsi";
> > > > > +};
> > > > 
> > > > What is it used for? Is it really necessary to keep it on at all time?
> > > 
> > > I think so.
> > > This is the supply for the MMC.
> > 
> > Then it's poorly named, and you should tie it to the MMC, and remove
> > the always-on if it's only used by the mmc. always-on is supposed to
> > be for regulators that shouldn't but turned off for the system to stay
> > running. Some MMC regulator doesn't fit that description.
>
> It's named upon the A33 power pin - "VCC-DSI".

Usually, it's based on the name of the output in the schematics,
precisely because, from one board to another, it might have different
usage.

> If I remove "always-on" the board still will work, since dcdc1 is tied to 
> mmc0. 
> vmmc-supply = <&reg_dcdc1>;
> 
> We assume this voltage will be always present and there are some pullups that 
> are tied to it (on i2c0 and i2c1 bus).  In this case should I remove "always-
> on" from the regulator node?

No, you should just tie that regulator to the i2c buses as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/9626bdc1/attachment.sig>

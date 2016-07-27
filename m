From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jul 2016 08:21:46 +0200
Subject: [PATCH v4] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <30014119.IrjfP0xFry@linux-cigu>
References: <1469450243-19138-1-git-send-email-stefan.mavrodiev@gmail.com>
 <20160726153352.GH7190@lukather> <30014119.IrjfP0xFry@linux-cigu>
Message-ID: <20160727062146.GA6560@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 08:12:29AM +0300, stefan.mavrodiev at gmail.com wrote:
> > > +&reg_dcdc1 {
> > > +	regulator-always-on;
> > > +	regulator-min-microvolt = <3300000>;
> > > +	regulator-max-microvolt = <3300000>;
> > > +	regulator-name = "vcc-dsi";
> > > +};
> > 
> > What is it used for? Is it really necessary to keep it on at all time?
> 
> I think so.
> This is the supply for the MMC.

Then it's poorly named, and you should tie it to the MMC, and remove
the always-on if it's only used by the mmc. always-on is supposed to
be for regulators that shouldn't but turned off for the system to stay
running. Some MMC regulator doesn't fit that description.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/bf0be398/attachment.sig>

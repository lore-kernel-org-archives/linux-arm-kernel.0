From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Nov 2012 15:15:43 +0000
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
In-Reply-To: <20121129120000.GJ2013@gmail.com>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
 <20121128085731.GH2013@gmail.com>
 <20121128163105.GA28698@sirena.org.uk>
 <20121129100808.GW2013@gmail.com>
 <20121129112058.GH32691@opensource.wolfsonmicro.com>
 <20121129120000.GJ2013@gmail.com>
Message-ID: <20121129151543.GK32691@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 12:00:00PM +0000, Lee Jones wrote:
> On Thu, 29 Nov 2012, Mark Brown wrote:

> > Right, which is why this mostly works, but it's still better to provide
> > an actual compatible string which we can be 100% certain will avoid
> > conflicts.  This is very low cost when one is already defining DT
> > bindings.

> I know that it's an easy thing to do, but I'm more worried about
> what would happen if the an I2C device is registered using the
> current way (stripping the compatible string and using it as a
> client look-up) and we also provide a compatible entry in the
> driver itself. Do you know if there is any danger of duplicate
> registration or suchlike?

That's totally fine, we try first with compatible properties and only
look for the fallback if there aren't any.

> > > Hence, there should be no need to have a compatible string in any i2c
> > > driver registration information.

> > We're getting away with it at present (and frankly nobody's going to
> > build in two different drivers for a chip of the same name for practical
> > systems anyway).

> Right. In the same way as we're getting away with it when we
> register a platform_device using the register/add routines.

Those are all completely Linux-defined of course which helps as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/b7149492/attachment.sig>

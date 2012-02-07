From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 11:25:47 +0000
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <20120207025624.GB15647@game.jcrosoft.org>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <20120206160907.GG10173@sirena.org.uk>
 <20120207025624.GB15647@game.jcrosoft.org>
Message-ID: <20120207112547.GC3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:56:24AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:09 Mon 06 Feb     , Mark Brown wrote:

> > > +	- udelay: half clock cycle time in us (may depend on each platform)

> > > +	udelay = <2>;		/* ~100 kHz */

> > Why not specify this in kHz and do the conversion in the driver?  It
> > seems a more intuitive thing to be specifying.  I appreciate that the
> > platform data used udelay but it seems an entirely unintuitive thing
> > from a user point of view even if it's what the implementation wants.

> because it's not accurate and on some platform you need to adapt it so we keep
> the udelay

Then you should clarify that in the documentation, it's not the cycle
time but the delay between GPIO operations which isn't quite the same
thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/7c9bba3f/attachment.sig>

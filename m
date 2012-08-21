From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 14:22:22 +0100
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821124243.GG10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
Message-ID: <20120821132222.GF7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 03:42:45PM +0300, Felipe Balbi wrote:
> On Tue, Aug 21, 2012 at 01:41:46PM +0100, Mark Brown wrote:
> > > +	regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
> > > +	dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);

> > I'd make these log messages dev_info() or something.

> dev_info() ? It'lll just make boot noisier for no good reason. Which
> user wants to see this during boot up ? That's a debugging feature for
> develop IMHO.

Most of the registers appeared to be chip revision information which is
most definitely useful to tell people about, though possibly with neater
formatting ("why is this batch of boards failing...  oh, right").  If
they're fixed device IDs then the driver should instead be verifying
that the registers contain the expected values and bombing out if they
don't.  Either way dev_dbg() isn't too helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/53e02add/attachment.sig>

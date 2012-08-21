From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 16:27:44 +0300
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821132222.GF7995@opensource.wolfsonmicro.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
Message-ID: <20120821132741.GI10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 02:22:22PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 03:42:45PM +0300, Felipe Balbi wrote:
> > On Tue, Aug 21, 2012 at 01:41:46PM +0100, Mark Brown wrote:
> > > > +	regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
> > > > +	dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
> 
> > > I'd make these log messages dev_info() or something.
> 
> > dev_info() ? It'lll just make boot noisier for no good reason. Which
> > user wants to see this during boot up ? That's a debugging feature for
> > develop IMHO.
> 
> Most of the registers appeared to be chip revision information which is
> most definitely useful to tell people about, though possibly with neater
> formatting ("why is this batch of boards failing...  oh, right").  If
> they're fixed device IDs then the driver should instead be verifying
> that the registers contain the expected values and bombing out if they
> don't.  Either way dev_dbg() isn't too helpful.

I still beg to differ. Even if it fails, dmesg will still contain the
message (provided you have it enabled). I really don't think we want
this to print to console on every boot.

If you're still testing your new batch of boards, you're not just a
simple user and you will have debugging enabled anyway. dev_info() will
be visible to anyone who's got a console running. Not sure how useful
that would be to my neighbor.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/ef82173b/attachment-0001.sig>

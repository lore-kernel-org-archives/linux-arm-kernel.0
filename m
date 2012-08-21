From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 15:20:08 +0100
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821140923.GL10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
 <20120821135240.GJ10347@arwen.pp.htv.fi>
 <20120821140803.GK7995@opensource.wolfsonmicro.com>
 <20120821140923.GL10347@arwen.pp.htv.fi>
Message-ID: <20120821142007.GP7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 05:09:24PM +0300, Felipe Balbi wrote:

> You can't possibly understand what that'll print. First of all, VEN_ID_H
> and VEN_ID_L should be ORed together. Second, the user will see the same
> message four times in a row, with different values, but see that driver
> claims that all four values refer to the device id. What this should do,
> is at least combine all four messages into a single one of the format:

> dev_(dbg|info)(&i2c->dev, "SMSCxxx devid: %02x rev: %02x venid: %02x\n",
> 	devid, rev, (venid_h << 8) | venid_l);

> or something similar.

Yes, I agree that the formatting here should also be improved - as I
said in one of my earlier mails if any of these things are fixed things
that should never change the driver should instead verify the value
rather than log it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/871c4971/attachment.sig>

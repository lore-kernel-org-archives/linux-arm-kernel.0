From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 24 Feb 2015 15:25:24 +0100
Subject: [RFC 02/11] i2c: add quirk checks to core
In-Reply-To: <20150112120814.GE12302@n2100.arm.linux.org.uk>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <20150112120814.GE12302@n2100.arm.linux.org.uk>
Message-ID: <20150224142524.GB18301@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 12:08:14PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 09, 2015 at 06:21:32PM +0100, Wolfram Sang wrote:
> > +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> > +{
> > +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> > +	return -EOPNOTSUPP;
> > +}
> 
> So, what happens if I open an I2C adapter, find a message which causes
> i2c_quirk_error() to be called, and then spin repeatedly calling that...
> Shouldn't there be some rate limiting to this?

Can be argued. Changed to dev_err_ratelimited(). Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/018d94c3/attachment.sig>

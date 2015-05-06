From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 06 May 2015 09:53:55 +0200
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <20150506065928.GP25193@pengutronix.de>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150505105513.GA1841@katana> <20150506065928.GP25193@pengutronix.de>
Message-ID: <3394114.re5da8pjTi@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 6. Mai 2015, 08:59:28 schrieb Uwe Kleine-K?nig:
> Hello,
> 
> On Tue, May 05, 2015 at 12:55:13PM +0200, Wolfram Sang wrote:
> > So what about adding a new property "i2c-slave-reg"? This does not only
> > prevent the confusion above, but also makes it very clear that this node
> > is an I2C slave without the need to encode that somehow in the
> > compatible property (although it probably should be described there as
> > well, still).
> 
> I admit I didn't follow the discussions referenced in the footnotes, but
> I wonder if the slave part should be added to the device tree at all.
> AFAICT it could (and so should) be completely userspace-defined which
> slave driver is used on which address. I imagine that for most
> controllers the bus addresses to use can be chosen more or less freely.
> So what am I missing?

if you had read the footnotes you would know :-) Our usecase is connect an 
embeedded controller via i2c to the host soc, similar to cros-ec, but here the 
ec is the i2c master. The ec connects keyboard, mouse, pwrmngt, and other 
stuff, for which the drivers are best implemented in kernel code AFAIK. 

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/afbd62ae/attachment-0001.sig>

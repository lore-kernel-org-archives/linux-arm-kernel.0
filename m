From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:36:44 +0100
Subject: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20150911123644.GU12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 12:02:21PM +0000, Ranjit Abhimanyu Waghmode wrote:

Please fix your mail client to word wrap within paragraphs and to quote
text without reflowing it - your messages are very hard to read.

> > > +	/* Controller may support more than one chip.
> > > +	 * This flag will enable that feature.
> > > +	 */
> > > +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both
> > chips */

> > This isn't saying that the controller supports more than one chip, it's saying that
> > the controller supports asserting more than one chip select at once which isn't
> > the same thing.  I'm also not entirely sure that this makes sense as a separate
> > feature to the data striping one - I'm struggling to think of a way to use this
> > sensibly separately to that.

> If the SPI controller is having more than one chip select and the data lines are distributed equally.
> And also there is requirement to activate all the chip selects in one go.

I'm not sure I understand the above, sorry.  At least not in so far as
how it relates to my concerns, especially the fact that the comment says
this enables support for more than one chip which is obviously a basic
SPI feature.

> Now we can consider following use cases:

> Suppose we need to send the same data to multiple slaves of same kind:
> Here the application need not to do individual slave access for writing, instead it can send data to all the devices in one go.

That's a *very* specific application which will only work for write only
devices - I'd be surprised if such systems actually had distinct chip
select lines at the CPU level.

> Let's take another case where application is trying to send data in such a way that first nibble of the byte will got to the one slave and the second nibble of the byte will go to the other slave:
> Here data in slave devices can be organized by taking advantage of above topology along with the support in hardware.

But do such devices actually exist?  I can imagine systems that might be
able to do that but I'd be very surprised to see anyone practically
designing them, they're going to be quite hard to use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/506d8cad/attachment.sig>

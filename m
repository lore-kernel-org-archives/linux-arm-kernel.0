From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 15 Aug 2011 19:22:13 +0300
Subject: GPMI-NAND Status?
In-Reply-To: <20110814081139.GD17063@parrot.com>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
Message-ID: <1313425340.8691.34.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-08-14 at 10:11 +0200, Ivan Djelic wrote:
> On Fri, Aug 05, 2011 at 02:51:33PM +0100, Wolfram Sang wrote:
> (...)
> > 
> > problem overwriting all-0xff data in NAND [2]
> > =============================================
> > 
> > Although it occured only when writing JFFS2 images so far, this is a generic
> > issue and needs to be fixed, right?
> > 
> > 
> (...)
> > [2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> 
> As explained in the thread linked above, this issue should be fixed in your
> flashing tool, _not_ in your driver. The nand device you are using does not
> support programming pages multiple times in a row; pretending it does in the
> special all-0xff case is inefficient (you need to detect all-0xff data) and
> unnecessary (just do not program blank pages !).

Hmm, isn't it also buggy because if my precious data contains 2KiB of
0xFFs (aligned to 2KiB boundary) then I will have no ECC protection for
this page? Or I miss something?

-- 
Best Regards,
Artem Bityutskiy

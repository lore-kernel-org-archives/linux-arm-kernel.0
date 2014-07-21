From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:01:32 +0800
Subject: [PATCH] ARM: i.MX6: add more chip revision support
In-Reply-To: <20140721064145.GA7350@pengutronix.de>
References: <1405921091-28748-1-git-send-email-shawn.guo@freescale.com>
 <20140721063520.GR23235@pengutronix.de>
 <20140721064145.GA7350@pengutronix.de>
Message-ID: <20140721070130.GJ8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 08:41:45AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Jul 21, 2014 at 08:35:20AM +0200, Sascha Hauer wrote:
> > On Mon, Jul 21, 2014 at 01:38:11PM +0800, Shawn Guo wrote:
> > > From: Jason Liu <r64343@freescale.com>
> > > 
> > > Add more revision support for the new i.MX6DQ tap-out (TO1.5).  This
> Is it "tap-out" or "tape-out"? A quick google request suggests the
> latter.

Yes, you're right.

> 
> > > TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
> > > and TO1.4 are never revealed.
> > 
> > So the chip identifies itself as 1.5 but the data sheet refers to it as
> > 1.3. Is there a way to make that clear somewhere? Otherwise it's really
> > confusing.
> Yeah, from the commit log I would have expected the following patch:
> 
> +	case 5:
> +		revision = IMX_CHIP_REVISION_1_3;
> +		break;
> 
> maybe with a code comment.

I did consider such fix-up when I was trying to submit Jason's patch
from FSL internal tree.  But this TO1.5 numbering has been already used
in a couple of FSL BSP releases.  We do not really want to maintain two
different numbering scheme between FSL BSP and upstream kernel.

> Also, the commit log only mentions i.MX6DQ; I
> wonder about the other imx6 variants. I hope they use the same logic?

This is another reason for that above fix-up may not be good.  This
revision mismatch between register and document is only with i.MX6DQ.
So far, only i.MX6DQ revision goes beyond 1.2, but I'm sure such
mismatch/mistake will not be with other imx6 variants.

Shawn

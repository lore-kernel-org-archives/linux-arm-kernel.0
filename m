From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Dec 2012 17:01:08 +0100
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <1355325103.3400.2.camel@sauron.fi.intel.com>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <1355325103.3400.2.camel@sauron.fi.intel.com>
Message-ID: <20121212160108.GA2607@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:11:43PM +0200, Artem Bityutskiy wrote:
> On Wed, 2012-12-05 at 21:46 +0100, Wolfram Sang wrote:
> > It could happen (1 out of 100 times) that NAND did not start up
> > correctly after warm rebooting, so the kernel could not find the UBI or
> > DMA timed out due to a stalled BCH. When resetting BCH together with
> > GPMI, the issue could not be observed anymore (after 10000+ reboots). We
> > probably need the consistent state already before sending any command to
> > NAND, even when no ECC is needed. I chose to keep the extra reset for
> > BCH when changing the flash layout to be on the safe side.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Huang Shijie <b32955@freescale.com>
> > Cc: Artem Bityutskiy <dedekind1@gmail.com>
> > Cc: David Woodhouse <david.woodhouse@intel.com>
> > ---
> > 
> > Would be really great to have in 3.7. Also a stable-candidate IMO.
> 
> Pushed to l2-mtd.git, thanks
> 
> If you believe this is suitable for stable, please let me know.

I strongly believe that.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/ca33f9a1/attachment.sig>

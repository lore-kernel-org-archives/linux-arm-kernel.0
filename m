From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Sep 2011 14:26:33 +0200
Subject: [PATCH v2 3/3] net/fec: add imx6q enet support
In-Reply-To: <20110921115821.GF28907@S2100-06.ap.freescale.net>
References: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
	<1316603432-20032-4-git-send-email-shawn.guo@linaro.org>
	<20110921113239.GF1966@pengutronix.de>
	<20110921115821.GF28907@S2100-06.ap.freescale.net>
Message-ID: <20110921122633.GH1966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 07:58:22PM +0800, Shawn Guo wrote:
> On Wed, Sep 21, 2011 at 01:32:39PM +0200, Wolfram Sang wrote:
> > 
> > > +/* Controller has GBIT support */
> > > +#define FEC_QUIRK_HAS_GBIT		(1 << 3)
> > 
> > Heh, this is not really a quirk, but a nice feature :) I think we can
> > drop QUIRK if we see driver_data more as "flags" instead of "quirks"?
> > Minor, though.
> > 
> As you have told, all these FEC_QUIRK_* are just flags actually.  The
> name was pick to keep the consistency, as they are all used for the
> same purpose.

I think introducing FEC_FEATURE_HAS_GBIT would be consistent enough, but
as I said, I don't mind much.

> > Also minor, but the patch looks like a good oportunity to start
> > replacing magic values with proper defines?
> > 
> There are already so many magic numbers.  It really deserves a separated
> patch.

That is the other possibility, yes. Which sadly never happened.

> I heard that Uwe had a plan to do that some time ago.  He gives up
> now? :)

I don't know about this case. Also, it is not about blaming here. It is
totally okay for you to say that you don't want to change your patch to
start replacing the magic values. I mainly wanted to point out the
oportunity here.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110921/780cd0f7/attachment.sig>

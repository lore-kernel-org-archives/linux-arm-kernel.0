From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 30 Jan 2013 08:58:32 +0100
Subject: [RFC 3/3] arm: mach-mxs: make enabling enet_out a legacy function
In-Reply-To: <20130130054833.GA24450@S2100-06.ap.freescale.net>
References: <1359470773-14290-1-git-send-email-w.sang@pengutronix.de>
 <1359470773-14290-4-git-send-email-w.sang@pengutronix.de>
 <20130130054833.GA24450@S2100-06.ap.freescale.net>
Message-ID: <20130130075832.GA13075@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 01:48:40PM +0800, Shawn Guo wrote:
> On Tue, Jan 29, 2013 at 03:46:13PM +0100, Wolfram Sang wrote:
> > @@ -351,7 +359,7 @@ static void __init tx28_post_init(void)
> >  	struct pinctrl *pctl;
> >  	int ret;
> >  
> > -	enable_clk_enet_out();
> > +	legacy_enable_clk_enet_out();
> 
> I think TX28 is the only case that really needs to turn on enet_out
> clock at platform level, since it has some dirty work about PHY to do
> here.  With with fec driver handling the clock, enable_clk_enet_out()
> can just be removed for other boards.

I would love to, but this will cause regression on boards which update
the kernel but not the devicetree (no third clock), or?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/f802a8ba/attachment.sig>

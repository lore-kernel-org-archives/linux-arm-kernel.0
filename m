From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 2 May 2012 18:34:41 +0800
Subject: [PATCH 09/11] ARM: imx6q: add ssi1 clk_lookup
In-Reply-To: <20120430121857.GL4141@pengutronix.de>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-10-git-send-email-richard.zhao@freescale.com>
 <20120427080412.GW17184@pengutronix.de>
 <20120427091055.GP28063@b20223-02.ap.freescale.net>
 <20120427092529.GA20478@pengutronix.de>
 <20120430020143.GA1857@richard-laptop>
 <20120430121857.GL4141@pengutronix.de>
Message-ID: <20120502103440.GA2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 02:18:57PM +0200, Sascha Hauer wrote:
> On Mon, Apr 30, 2012 at 10:01:46AM +0800, Richard Zhao wrote:
> > > > > 
> > > > > 	clk_register_clkdev(clk[ipg], "ipg", "2028000.ssi");
> > > > ssi don't have ipg gate. We can let it always on for imx6q.
> > > 
> > > Can you please ask your IC guys for clarification?
> > > 
> > > For example on i.MX5 we have a ssi ipg clock and a ssi serial clock.
> > > Both can be gated with two individual gate bits.
> > > 
> > > The i.MX6 datasheet (and also several other i.MX datasheets) is quite
> > > nebulous. The i.MX6 has only one gate bit for each SSI unit, but
> > > it's not clear if this bit actually gates both the ipg and serial
> > > clock or only one of them.
> > You're right. ipg and serial clocks share the same gate. How do we
> > handle it? I think it's not the only one and won't be last one.
> 
> We don't have support for a single gate gating two clocks right now and
> I don't know how this fits into the clock framework.
> We could pretend that only the ipg clock is gateable because this is
> needed anyway when the SSI unit is used.
Shawn, will you add clk ssi_ipg?

Thanks
Richard
> 
> It seems we need a proper solution for this later.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

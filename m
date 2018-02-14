From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Feb 2018 08:22:10 -0800
Subject: [PATCH] ARM: OMAP: clock: Fix debugfs_create_*() usage
In-Reply-To: <20180109173734.tplddyd4d3akrzjr@darkstar.musicnaut.iki.fi>
References: <1514906735-8977-1-git-send-email-geert+renesas@glider.be>
 <20180109173734.tplddyd4d3akrzjr@darkstar.musicnaut.iki.fi>
Message-ID: <20180214162210.GG6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [180109 17:40]:
> Hi,
> 
> On Tue, Jan 02, 2018 at 04:25:35PM +0100, Geert Uytterhoeven wrote:
> > When exposing data access through debugfs, the correct
> > debugfs_create_*() functions must be used, depending on data type.
> > 
> > Remove all casts from data pointers passed to debugfs_create_*()
> > functions, as such casts prevent the compiler from flagging bugs.
> > 
> > Correct all wrong usage:
> >   - clk.rate is unsigned long, not u32,
> >   - clk.flags is u8, not u32, which exposed the successive
> >     clk.rate_offset and clk.src_offset fields.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v4.16/fixes thanks.

Tony

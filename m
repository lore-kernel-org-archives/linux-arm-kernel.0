From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 14 May 2014 20:53:08 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzNdIEFSTTogaS5NWDEgY2xrOiBBZGQgZGV2aWNl?=
 =?UTF-8?B?dHJlZSBzdXBwb3J0?=
In-Reply-To: <20140513173143.GU5858@pengutronix.de>
References: <1399997116-4313-1-git-send-email-shc_work@mail.ru>
 <1399999493.354004023@f391.i.mail.ru>
 <20140513173143.GU5858@pengutronix.de>
Message-ID: <1400086388.344798582@f388.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 13 May 2014 19:31:43 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, May 13, 2014 at 08:44:53PM +0400, Alexander Shiyan wrote:
> > Tue, 13 May 2014 13:28:28 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> > > On Tue, May 13, 2014 at 1:24 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > > > Tue, 13 May 2014 13:18:40 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> > > >> On Tue, May 13, 2014 at 1:05 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > > >>
> > > >> > +       clk[IMX1_CLK_DUMMY] =
> > > >> > +               imx_clk_fixed("dummy", 0);
> > > >> > +       clk[IMX1_CLK_CLK32] =
> > > >> > +               imx_obtain_fixed_clock("clk32", fref);
> > > >> > +       clk[IMX1_CLK_CLK16M_EXT] =
> > > >> > +               imx_clk_fixed("clk16m_ext", 16000000);
> > > >> > +       clk[IMX1_CLK_CLK16M] =
> > > >> > +               imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
> > > >>
> > > >> Why don't you put each entry into a single line instead?
> > > >>
> > > >> Even if it gets larger than 80 columns, it would be easier to read.
> > > >
> > > > I thought about it, but came to the conclusion that it is better to observe
> > > > the kernel rules.
> > > 
> > > Do you mean checkpatch complaint?
> > > 
> > > Then try to make checkpatch happy with other clock file such as
> > > arch/arm/mach-imx/clk-imx6q.
> > > 
> > > The result will be unreadable :-)
> > 
> > As another solution we can use macros, something like this:
> > 
> > #define IMXCLK_MUX(id, name, reg, off, sz, arr)	\
> > 	clk[id] = imx_clk_mux(name, reg, off, sz, arr, ARRAY_SIZE(arr))
> 
> Please don't do that. We have i.MX specific wrapper functions. Wrapping
> these again with macros doesn't improve the situation. I'm with Fabio
> here, I would prefer the functions in a single line.

OK. Shawn, if no objections to parts 1 and 2, I would like them to be applied.

---

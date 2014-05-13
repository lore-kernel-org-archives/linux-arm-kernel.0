From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 13 May 2014 20:44:53 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzNdIEFSTTogaS5NWDEgY2xrOiBBZGQgZGV2aWNl?=
 =?UTF-8?B?dHJlZSBzdXBwb3J0?=
In-Reply-To: <CAOMZO5CNk4uAu0OujRgiJpU2gHJpAnD4zpqxSHd4hXo3fnJ4_w@mail.gmail.com>
References: <1399997116-4313-1-git-send-email-shc_work@mail.ru>
 <1399998253.839894262@f391.i.mail.ru>
 <CAOMZO5CNk4uAu0OujRgiJpU2gHJpAnD4zpqxSHd4hXo3fnJ4_w@mail.gmail.com>
Message-ID: <1399999493.354004023@f391.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 13 May 2014 13:28:28 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Tue, May 13, 2014 at 1:24 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > Tue, 13 May 2014 13:18:40 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> >> On Tue, May 13, 2014 at 1:05 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> >>
> >> > +       clk[IMX1_CLK_DUMMY] =
> >> > +               imx_clk_fixed("dummy", 0);
> >> > +       clk[IMX1_CLK_CLK32] =
> >> > +               imx_obtain_fixed_clock("clk32", fref);
> >> > +       clk[IMX1_CLK_CLK16M_EXT] =
> >> > +               imx_clk_fixed("clk16m_ext", 16000000);
> >> > +       clk[IMX1_CLK_CLK16M] =
> >> > +               imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
> >>
> >> Why don't you put each entry into a single line instead?
> >>
> >> Even if it gets larger than 80 columns, it would be easier to read.
> >
> > I thought about it, but came to the conclusion that it is better to observe
> > the kernel rules.
> 
> Do you mean checkpatch complaint?
> 
> Then try to make checkpatch happy with other clock file such as
> arch/arm/mach-imx/clk-imx6q.
> 
> The result will be unreadable :-)

As another solution we can use macros, something like this:

#define IMXCLK_MUX(id, name, reg, off, sz, arr)	\
	clk[id] = imx_clk_mux(name, reg, off, sz, arr, ARRAY_SIZE(arr))

...
	IMXCLK_MUX(IMX1_CLK_PREM, "prem", CCM_CSCR, 16, 1, prem_sel_clks);

---

From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 16 May 2012 11:26:49 +0530
Subject: [PATCH] clk: SPEAr600: Fix ethernet clock name for DT based
 probing
In-Reply-To: <CAJOA=zNe0yP5e75=fLTFAZMVZ=DsFF5xxkuear2C7sLD_XrGtA@mail.gmail.com>
References: <1336725678-29327-1-git-send-email-sr@denx.de>
 <4FB07D2B.6010409@st.com>
 <CAJOA=zNe0yP5e75=fLTFAZMVZ=DsFF5xxkuear2C7sLD_XrGtA@mail.gmail.com>
Message-ID: <CAOh2x==qiy7LHd_pyDX67vhcM91obPsVuinhBJ_WxWv+UJBFvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 16, 2012 10:32 AM, "Turquette, Mike" <mturquette@ti.com> wrote:
>
> On Sun, May 13, 2012 at 8:34 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> > On 5/11/2012 2:11 PM, Stefan Roese wrote:
> >> diff --git a/drivers/clk/spear/spear6xx_clock.c
b/drivers/clk/spear/spear6xx_clock.c
> >> index f9a20b3..bf33c1d 100644
> >> --- a/drivers/clk/spear/spear6xx_clock.c
> >> +++ b/drivers/clk/spear/spear6xx_clock.c
> >> @@ -298,7 +298,7 @@ void __init spear6xx_clk_init(void)
> >>
> >>       clk = clk_register_gate(NULL, "gmac_clk", "ahb_clk", 0,
PERIP1_CLK_ENB,
> >>                       GMAC_CLK_ENB, 0, &_lock);
> >> -     clk_register_clkdev(clk, NULL, "gmac");
> >> +     clk_register_clkdev(clk, NULL, "e0800000.ethernet");
> >>
> >>       clk = clk_register_gate(NULL, "i2c_clk", "ahb_clk", 0,
PERIP1_CLK_ENB,
> >>                       I2C_CLK_ENB, 0, &_lock);
> >
> > Acked-by: Viresh Kumar <viresh.kumar@st.com>
>
> Do you want me to take this?  Spear didn't originally go through me
> but I can take it if that is the intent.
>

Sure. Go ahead.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/178decb8/attachment-0001.html>

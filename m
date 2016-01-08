From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 08 Jan 2016 10:46:26 +0100
Subject: [PATCH v2 04/12] clk: rockchip: rk3036: enable the
 CLK_IGNORE_UNUSED flag for sclk_i2s_out
In-Reply-To: <568F80BA.6060209@gmail.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <290434099.8XFZ9qmNRz@phil> <568F80BA.6060209@gmail.com>
Message-ID: <20757797.djuaztrzGE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Freitag, 8. Januar 2016, 17:26:18 schrieb Caesar Wang:
> ? 2016?01?07? 18:05, Heiko Stuebner ??:
> > Am Donnerstag, 7. Januar 2016, 16:25:47 schrieb Caesar Wang:
> >> SCLk_I2S_OUT is the noc bus clock for i2s module, this clock is used by
> >> extra codecs.
> >> 
> >> Due to it shouldn't belong to any driver, but we need it enabled,
> >> so just mark it as the CLK_IGNORE_UNUSED flag.
> > 
> > What makes you think it shouldn't belong to any driver?
> > 
> > In most schematics I have, i2s_clkout is going to some clock-input of
> > the
> > audio codec - probably the MCLK input on your rt5616. And while the new
> > rt5616 driver does not seem to do clock handling, it should just handle
> > the clock using the normal APIs.
> 
> You are right,  that's seem has to find the root cause.
> I'm wonder that the codec/i2s is working in kernel v4.1 patch without it.
> 
> In general,  the MLCK will be handled in i2s driver if the cpu side is
> master.

looking at the rt5616 datasheet, that would be BCLK1 instead I think. This 
one does differentiate between being master/slave.

The master/sysclk (mclk) is also handled in other drivers in all cases. 
(da7213.c, da7219.c, max98090.c, max98095.c, probably more)


Heiko

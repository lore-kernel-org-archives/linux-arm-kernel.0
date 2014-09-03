From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 3 Sep 2014 10:08:28 +0200
Subject: [PATCH 0/5] clk: at91: fix USB clk support on at91rm9200/sam9 SoCs
In-Reply-To: <20140902223846.5251.86384@quantum>
References: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140902223846.5251.86384@quantum>
Message-ID: <20140903100828.69cc79fe@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, 02 Sep 2014 15:38:46 -0700
Mike Turquette <mturquette@linaro.org> wrote:

> Quoting Boris BREZILLON (2014-09-02 00:50:13)
> > Hi,
> > 
> > This patch series fixes several bugs in the PLL driver preventing a proper
> > set_rate on the PLL clk.
> > It also enables propagation of set_rate request on the USB clk in order to
> > configure the PLL rate according to the USB block requirement (48 MHz).
> > 
> > Note that existing kernels, relying on the PLL configuration made by the
> > the bootloader should not be impacted by this bug, but others (those
> > directly booting from at91bootstrap or not enabling USB support in the
> > bootloader) will be.
> > 
> > This bug was reported by Ga?l, who's directly booting the kernel from the
> > bootstrap.
> 
> Applied to clk-next.

Thanks for applying this series to clk-next, but I wonder if we
shouldn't try to get this merged in 3.17 (in order to avoid back-porting
these fixes to 3.17 stable branch).

I know I said it shouldn't impact that much users, but IMHO we
shouldn't rely on this assumption.

Let me know if you're okay to take these patches in clk-fixes, because
this patch [1] needs to be applied first (I guess Nicolas will take it
through his -fixes branch).

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/9/1/634

> 
> Regards,
> Mike
> 
> > 
> > Best Regards,
> > 
> > Boris
> > 
> > Boris BREZILLON (5):
> >   clk: at91: fix PLL_MAX_COUNT macro definition
> >   clk: at91: rework PLL rate calculation
> >   clk: at91: fix recalc_rate implementation of PLL driver
> >   clk: at91: rework rm9200 USB clock to propagate set_rate to the parent
> >     clk
> >   clk: at91: fix div by zero in USB clock driver
> > 
> >  drivers/clk/at91/clk-pll.c | 160 +++++++++++++++++++++++----------------------
> >  drivers/clk/at91/clk-usb.c |  20 ++++--
> >  2 files changed, 96 insertions(+), 84 deletions(-)
> > 
> > -- 
> > 1.9.1
> > 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

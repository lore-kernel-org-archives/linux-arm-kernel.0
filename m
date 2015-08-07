From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 07 Aug 2015 13:36:38 +0200
Subject: [PATCH v4 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <55C47D59.8080403@rock-chips.com>
References: <1438939872-2116-1-git-send-email-hl@rock-chips.com>
 <55C47D59.8080403@rock-chips.com>
Message-ID: <2226681.uyCeUEdNHm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 7. August 2015, 17:41:45 schrieb hl:
> Hi Heiko,
> 
> > pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> > handling this is not always the case anymore. So add it to the list
> > of critical clocks for now.
> > 
> > From: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> 
>      is it the right way?  if it still can not meet the requirement,
> please let me know.

nearly, but not quite ;-)

You can take a look at my minnie patch [0] for inspiration.


Also please make sure to include linus.walleij at linaro.org also in this
first mail. This clock patch is a prequisite for the pinctrl change so
we would like Linus Walleij to merge both into his pinctrl tree.

Ideally both times in the "To" and not the "Cc" recipients, as To vs. Cc
is often used to distinguish whom you want to apply the patch.


Heiko


[0] http://lists.infradead.org/pipermail/linux-rockchip/2015-August/003608.html




> 
> > ---
> > Changes in v4:
> > - Add From: Heiko Stuebner <heiko@sntech.de>
> > 
> >   drivers/clk/rockchip/clk-rk3288.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/rockchip/clk-rk3288.c
> > b/drivers/clk/rockchip/clk-rk3288.c index 0df5bae..9040878 100644
> > --- a/drivers/clk/rockchip/clk-rk3288.c
> > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > @@ -780,6 +780,7 @@ static const char *const rk3288_critical_clocks[]
> > __initconst = {> 
> >   	"aclk_cpu",
> >   	"aclk_peri",
> >   	"hclk_peri",
> > 
> > +	"pclk_pd_pmu",
> > 
> >   };
> >   
> >   #ifdef CONFIG_PM_SLEEP

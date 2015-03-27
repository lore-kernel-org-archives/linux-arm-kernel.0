From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Mar 2015 14:54:10 +0100
Subject: at91 clocks
In-Reply-To: <55155262.9030501@microbit.se>
References: <55117568.6090202@microbit.se> <20150325013201.3f01fc22@bbrezillon>
 <55127AA6.5050902@microbit.se> <20150325173751.0d6479df@bbrezillon>
 <5513D701.2080201@microbit.se> <20150326162827.041c051a@bbrezillon>
 <55152F3E.60004@microbit.se> <20150327132003.6caf3689@bbrezillon>
 <20150327132543.08ad636c@bbrezillon> <55155262.9030501@microbit.se>
Message-ID: <20150327145410.39873958@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015 13:51:46 +0100
Jonas Andersson <jonas@microbit.se> wrote:

> Hi Boris,
> On 2015-03-27 13:25, Boris Brezillon wrote:
> > On Fri, 27 Mar 2015 13:20:03 +0100
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >
> >
> >>> I tested with IS_ERR, changed this to IS_ERR_OR_NULL, but the pointer is ok.
> >> Can you print clk_get_rate(parent_clk) result ?
> > Could you also paste me the whole clk_summary content ?
> >
> >
> http://pastie.org/10057268

Could you try with this patch [1] ?
Anyway, I don't understand why clk_set_rate returns 0 even when it
fails to set the appropriate rate.
Could you add some traces in drivers/clk/at91/clk-pll.c
(clk_pll_round_rate, clk_pll_set_rate and clk_pll_get_best_div_mul) ?

Thanks,

Boris

[1]http://code.bulix.org/gxxhc4-88138

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 30 Jul 2016 07:18:14 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8
 bits DDR transfers
In-Reply-To: <20160729191730.GG6215@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
 <20160729191730.GG6215@lukather>
Message-ID: <20160730071814.92d803eaa5bd8303a87bd5e5@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jul 2016 21:17:30 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > What happens if you actually want to set it to 100MHz?
> > 
> > There is no SDXC_CLK_100M in the mainline driver, and 100MHz is asked
> > only for 8 bits DDR at 50MHz.
> 
> You're missing the point.
> 
> clk_set_rate is supposed to apply a rate as close as possible as
> requested, there's no reason why you would request a rate twice as
> high as need.
> 
> You want to switch the clock from one mode to another, fine, create a
> new function for that. But don't hack an existing one.

I will not change the core clock stuff for this marginal case.
Flagging the clock as 'new mode capable' is enough.
Anyway, setting the 'new mode' bit to the clock divides the rate by
two, so, there is no reason to not use it.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

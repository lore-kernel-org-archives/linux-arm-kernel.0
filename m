From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 13 Jun 2013 01:40:05 +0200
Subject: [PATCH v3 5/7] clk: add basic Rockchip rk3066a clock support
In-Reply-To: <20130612230234.GB9016@quad.lixom.net>
References: <201306111328.52679.heiko@sntech.de>
 <201306130045.41723.heiko@sntech.de> <20130612230234.GB9016@quad.lixom.net>
Message-ID: <201306130140.05981.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. Juni 2013, 01:02:34 schrieb Olof Johansson:
> On Thu, Jun 13, 2013 at 12:45:41AM +0200, Heiko St?bner wrote:
> > Part of me simply wants to wait for this - but rockchip stuff might be to
> > late for 3.11 anyway, as we're near rc6.
> 
> For a new platform like this, it's useful to get some of the drivers to
> land even if the main platform code isn't. Where things tend to get messy
> is when we have to add a lot of code late in the cycle that has a lot of
> external dependencies, since everybody then has to scramble about getting
> things sorted out.
> 
> It's not too late for 3.11 yet, and in particular it'd be nice to see
> things like clock and pinctrl stuff go in even if some other stuff misses
> the train.

pinctrl is already in Linus Walleijs tree :-)

Tomorrow I'll try to send the mmc stuff to the mmc lists, as my dw-mmc 
dependency from Dinh Nguyen also seems to go this way.

The clocks are the really hard part, simply because Mike's upcoming dt support 
for the divider and mux clocks will let me get rid of the small clocks that 
simply hold. And of course I also need the HIWORD_MASK flag for the clocks from 
the hisilicon series.

Is there some sane intermediate step for the clocks? One possibility that 
comes to mind, would be to only declare the gates and provide fixed rate 
parents to the timer and mmc and add the divs and muxes when Mikes dt patches 
are ready.

I.e. I would keep the gate clocks grouped like now to not have to declare 160 
individual gates later :-)

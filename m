From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jan 2014 09:13:23 -0800
Subject: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
In-Reply-To: <20140115035011.4167.96678@quantum>
References: <20140109231513.GA11648@saruman.home> <52CFC2F1.706@ti.com>
 <20140110161352.GG6665@saruman.home> <52D02037.3090705@ti.com>
 <20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com>
 <20140114203613.GA604@saruman.home>
 <20140115020421.GA24195@saruman.home>
 <20140115031632.4167.2698@quantum>
 <20140115035011.4167.96678@quantum>
Message-ID: <20140115171323.GA22739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Turquette <mturquette@linaro.org> [140114 19:52]:
> > 
> > These 40 patches apply very cleanly on top of clk-next with 2
> > exceptions:
> > 
> > 1) I did not apply "[PATCH 30/42] ARM: dts: AM35xx: use DT clock data"
> > because I do not have arch/arm/boot/dts/am3517.dtsi in clk-next (based
> > on 3.13-rc1).
> > 
> > 2) Minor merge conflict in arch/arm/boot/dts/omap3.dtsi which I think I
> > resolved correctly but would like verification.
> > 
> > I'd prefer to simply merge these patches into clk-next, which is the
> > most straightforward route. Any ideas on how to handle the missing
> > AM35xx dtsi data? It can always go as a separate fix after this stuff
> > gets merged which, ironically, is how that file was created in the first
> > place.

You could do something like this to take advantage of fast forward and
not have to do a merge back from mainline:

$ git checkout -b am3517-clk v3.13-rc8 # or any other -rc with am3517.dtsi
$ git merge clk-next-omap # this fast forwards clk-next-omap to the desired -rc
$ git am am3517-clk-patch
$ git checkout clk-next
$ git merge clk-next-omap # this fast forwards clk-next to the desired -rc

Regards,

Tony 

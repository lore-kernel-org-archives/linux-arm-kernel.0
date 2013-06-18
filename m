From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 19:13:45 +0200
Subject: [PATCH v3 06/10] clk: exynos5420: register clocks using common
 clock framework
In-Reply-To: <9285029.CIld1HyBWB@amdc1227>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <201306181601.16795.arnd@arndb.de> <9285029.CIld1HyBWB@amdc1227>
Message-ID: <201306181913.45484.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tomasz Figa wrote:
> This is a binding that has been defined for Samsung Common Clock Framework 
> drivers. Exynos4 and Exynos5250 use the same convention. The numbers are 
> defined in a way that should allow adding further clocks of particular types in 
> future as need for such shows up.

I see, it's probably too late to change that then. Maybe if there is an Exynos6
this should be done differently though.

> Physically there is one clock controller (CMU) which has a lot of dividers, 
> muxes and gates and so it is represented as a single device node.

Some platforms just put device nodes for their clocks under the clock controller
node, which would have helped here. Another option would be to use #clock-cells=<2>
and make the first cell the type of the clock, and the second one the number.

Also, if I understand things correctly, simple fixed rate clocks would normally
not go into the clock driver at all when they are not controller by it.

	Arnd

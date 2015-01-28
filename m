From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Jan 2015 11:15:05 +0100
Subject: [PATCH 0/3] ARM: rockchip: provide the watchdog with a clock
In-Reply-To: <1736604.toH3biuFW2@phil>
References: <1736604.toH3biuFW2@phil>
Message-ID: <2144701.MzC17KKY9c@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 21. Januar 2015, 20:54:50 schrieb Heiko St?bner:
> The snps,dw-wdt needs to read the clock-rate of its supplying clock
> for some operations. The clock itself is based on pclk_pd_alive
> and is indeed gateable. The caveat is that the gate is living in the
> so-called secure-GRF, which isn't even writeable in some boot-modes.
> 
> But to have an actual clock reference to the correct clock, implement
> a fixed-factor clock, to be substituted when we can control the actual
> gate safely.
> 
> Heiko Stuebner (3):
>   clk: rockchip: add id for watchdog pclk on rk3288
>   clk: rockchip: add a dummy clock for the watchdog pclk on rk3288
>   ARM: dts: rockchip: add rk3288 watchdog clock

with the clock changes (patches 1+2) being accepted into the clock tree, I've 
now also added the third patch to my dts branch.


Heiko

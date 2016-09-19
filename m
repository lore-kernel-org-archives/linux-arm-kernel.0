From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Sep 2016 17:50:56 +0200
Subject: [PATCH v2] ARM: mvebu: Select corediv clk for all mvebu v7 SoC
In-Reply-To: <20160919154824.22919-1-gregory.clement@free-electrons.com>
References: <20160919154824.22919-1-gregory.clement@free-electrons.com>
Message-ID: <20160919155056.2toxhbpyr3xjw55m@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 05:48:24PM +0200, Gregory CLEMENT wrote:
> Since the commit bd3677ff31a3 ("clk: mvebu: Remove corediv clock from
> Armada XP"), the corediv clk is no more selected for Armada XP, however
> this clock is used for Armada XP using the compatible
> armada-370-corediv-clock.
> 
> While since commit 1594d568c6e3 ("clk: mvebu: Move corediv config to
> mvebu config") Armada 38x and Armada 375 got corediv support again, not
> only Armada XP was missed but also Armada 39x.
> 
> Actually all the SoC selecting MVEBU_V7 config need this clock:
> git grep "\-corediv-clock" arch/arm/boot/dts
> arch/arm/boot/dts/armada-370-xp.dtsi: compatible = "marvell,armada-370-corediv-clock";
> arch/arm/boot/dts/armada-375.dtsi:    compatible = "marvell,armada-375-corediv-clock";
> arch/arm/boot/dts/armada-38x.dtsi:    compatible = "marvell,armada-380-corediv-clock";
> arch/arm/boot/dts/armada-39x.dtsi:    compatible = "marvell,armada-390-corediv-clock"
> 
> This commit now fixes this behavior by letting MVEBU_V7 select
> MVEBU_CLK_COREDIV.
> 
> Fixes: bd3677ff31a3 ("clk: mvebu: Remove corediv clock from Armada XP")
> Cc: stable at vger.kernel.org
> Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

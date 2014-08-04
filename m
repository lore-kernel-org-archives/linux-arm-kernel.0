From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Aug 2014 19:29:36 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add bootargs setting the correct
 serial console
In-Reply-To: <1539097.4Cm43oOanj@diego>
References: <5084600.YbBVvXy6Ug@diego> <1539097.4Cm43oOanj@diego>
Message-ID: <201408041929.36275.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 August 2014, Heiko St?bner wrote:
> Uart2 seems to be designated debug uart for all Rockchip platforms.
> On all rk30xx and rk31xx boards I've seen so far, this uart was used
> for the console and the rk3288 TRM even describes it as debug uart.
> 
> Thus add it to the core SoC dtsi files to not duplicate the same
> information on every board.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Shouldn't this be done through the /aliases node for the port selection
and the current-speed property for the bit rate?

I don't think we normally want to have these overridden by the command
line, even if that's what other platforms do.

	Arnd

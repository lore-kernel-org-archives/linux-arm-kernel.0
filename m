From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 12 Aug 2017 01:33:36 +0200
Subject: [PATCH] arm64: dts: rockchip: add rk3328-rock64 board
In-Reply-To: <8e116c15-905b-3392-5b1f-c6e31c342d94@rock-chips.com>
References: <20170809220408.4301-1-heiko@sntech.de>
 <8e116c15-905b-3392-5b1f-c6e31c342d94@rock-chips.com>
Message-ID: <6368063.kvbHAoN7Jh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Donnerstag, 10. August 2017, 09:24:18 CEST schrieb Shawn Lin:
> On 2017/8/10 6:04, Heiko Stuebner wrote:
> > The ROCK64 is a credit card size 4K60P HDR Media Board Computer using the
> > Rockchip RK3328 Quad-Core ARM Cortex A53 64-Bit Processor and supporting
> > up to 4GB 1600MHz LPDDR3 memory. It provides eMMC module socket, MicroSD
> > Card slot, Pi-2 Bus, Pi-P5+ Bus, USB 3.0 and many others peripheral
> > devices interface for makers to integrate with sensors and devices.
> > 
> > The devicetree currently supports basic peripherals, with more to be
> > added later on.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---

[...]

> > +&emmc {
> > +	bus-width = <8>;
> > +	cap-mmc-highspeed;
> > +	supports-emmc;
> > +	disable-wp;
> > +	non-removable;
> > +	num-slots = <1>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> > +	status = "okay";
> > +};
> > +
> 
> supports-{emmc, sd, sdio} aren't vaild properties.
> If you do want to speedup the init process and you
> could add no-sd and no-sdio for emmc.
> 
> num-slots is deprecated and would be cleaned from all dts for 4.14
> cycle. And disable-wp is only used for SD card now.
> 
> The same comment for the following sd and sdio nodes.

Thanks for keeping an eye on the mmc properties. I've dropped
the offending ones and send a v2 patch.


Heiko

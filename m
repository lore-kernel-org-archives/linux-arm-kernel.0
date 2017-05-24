From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 24 May 2017 16:00:53 +0800
Subject: [PATCH] ARM: dts: rockchip:remove hs200 support for firefly reload
In-Reply-To: <1495612242-28873-1-git-send-email-eddie.cai.linux@gmail.com>
References: <1495612242-28873-1-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <65c7a442-4b2e-65e4-ea5e-0a723c257397@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017/5/24 15:50, Eddie Cai wrote:
> due to layout limitation. not all of the reload board can support hs200.
> so remove hs200 support to make all board can boot up.

You now also remove DDR52, so all reload boards run at high speed mode?

I'm curious about what was the layout limitation that mmc tuning
process could never help?

>
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> ---
>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> index 4cfa109..56ac1e6f 100644
> --- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> @@ -75,8 +75,6 @@
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	disable-wp;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
>  	non-removable;
>  	num-slots = <1>;
>  	pinctrl-names = "default";
>

From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 2 Mar 2016 16:05:15 -0800
Subject: [PATCH v2 3/6] rockchip: power-domain: add support for sub-power
 domains
In-Reply-To: <1828664.WUMlfLyMuz@phil>
References: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
 <1455764838-12928-4-git-send-email-zhangqing@rock-chips.com>
 <1828664.WUMlfLyMuz@phil>
Message-ID: <CAOi56cX-79UvCLEY5ddvWFoW=qRVmF-wcCt_0stATK_KNWU8vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 4:20 PM, Heiko Stuebner <heiko@sntech.de> wrote:

> In general the code looks like you're going to group the domains
> hirarchically, like
>
>        power: power-controller {
>                compatible = "rockchip,rk3399-power-controller";
>
>                pd_cci {
>                        reg = <RK3399_PD_CCI>;
>                        clocks = ...;
>
>                         pd_cci0 {
>                                 reg = <RK3399_PD_CCI0>;
>                                 clocks = ...;
>                         };
>                };
>        };
>
> This isn't documented in the dt-binding and also isn't really improving
> reading these declarations. Instead as I said before, I think I'd like more
> get inspiration from how Exynos is doing that already

Heiko and I had a chat offline about this, and I mentioned that the
Exynos way is not the preferred way.  The nesting that is being done
here (and in v4) is the better way, and is fully supported by the
genpd code.

Kevin

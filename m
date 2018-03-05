From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Mon, 5 Mar 2018 11:22:39 +0100
Subject: [PATCH v3 3/3] arm64: dts: rockchip: Avoid wakeup when inserting
 the pen
In-Reply-To: <20180302035102.10084-4-jeffy.chen@rock-chips.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
 <20180302035102.10084-4-jeffy.chen@rock-chips.com>
Message-ID: <CAFqH_50YFm7EYEtt=9AoCUwvVU+Vuw51PYx=hF_u=KBgKmPTDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Thanks for the patch.

2018-03-02 4:51 GMT+01:00 Jeffy Chen <jeffy.chen@rock-chips.com>:
> Add wakeup event action for Pen Insert gpio key, to avoid wakeup when
> inserting the pen.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 191a6bcb1704..ef2de0057c5c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -134,6 +134,8 @@
>                 gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
>                 linux,code = <SW_PEN_INSERTED>;
>                 linux,input-type = <EV_SW>;
> +               /* Wakeup only when ejecting */
> +               wakeup-event-action = <EV_ACT_DEASSERTED>;
>                 wakeup-source;
>         };
>  };
> --
> 2.11.0
>
>

Works as expected on my Kevin

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

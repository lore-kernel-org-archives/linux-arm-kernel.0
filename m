From: dianders@chromium.org (Doug Anderson)
Date: Fri, 3 Oct 2014 14:21:03 -0700
Subject: [PATCH v7 5/5] ARM: dts: enable Thermal on rk3288-evb board
In-Reply-To: <1411900693-30484-6-git-send-email-caesar.wang@rock-chips.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
 <1411900693-30484-6-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=V6c1tGxxTTDyExRkW0fqFVY6v2OxJauoJ_xwZdXX0Tmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Sun, Sep 28, 2014 at 3:38 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> when a thermal shutdown at 125C.Via GPIO give PMIC,
> Reset the entire chip.
>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> index 2964370..a6872aa 100644
> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -101,6 +101,11 @@
>         status = "okay";
>  };
>
> +&tsadc {
> +       reset-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;

I don't see "reset-gpios" mentioned in the bindings or the code.  I
think you can just remove this, right?

> +       status = "okay";
> +};
> +
>  &pinctrl {
>         buttons {
>                 pwrbtn: pwrbtn {
> --
> 1.9.1
>
>

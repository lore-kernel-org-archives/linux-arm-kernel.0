From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 19:48:22 +0900
Subject: [PATCH v3 2/2] arm64: dts: uniphier: add nodes of thermal monitor
 and thermal zone for LD20
In-Reply-To: <1499255595-31805-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1499255595-31805-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAS38+GDnhC3Hgymt1gg6QCPG-q5SJo27Qsc3ErZv5RsnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hayashi-san,


2017-07-05 20:53 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add nodes of thermal monitor and thermal zone for UniPhier LD20 SoC.
> The thermal monitor is included in sysctrl.
>
> Furthermore, since the reference board doesn't have a calibrated value of
> thermal monitor, this patch gives the default value for LD20 reference
> board.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  4 +++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 40 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> index 609162a..d7f6b39 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> @@ -86,3 +86,7 @@
>  &i2c0 {
>         status = "okay";
>  };
> +
> +&pvtctl {
> +       socionext,tmod-calibration = <0x0f22 0x68ee>;
> +};


I think this calib value is shared among all boards
(ref and global).


Please move it to the SoC dtsi.




> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu_alert>;
> +                                       cooling-device = <&cpu0 (-1) (-1)>;
> +                               };
> +                               map1 {
> +                                       trip = <&cpu_alert>;
> +                                       cooling-device = <&cpu2 (-1) (-1)>;
> +                               };
> +                       };
> +               };
> +       };
> +

After all, I decided to use dt-bindings headers.
Could you use THERMAL_NO_LIMIT for clarification?




-- 
Best Regards
Masahiro Yamada

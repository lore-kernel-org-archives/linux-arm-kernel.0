From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 8 Dec 2017 10:52:11 +0800
Subject: [PATCH v2 2/3] arm64: allwinner: axp803: Add drivevbus regulator
In-Reply-To: <1512673460-7865-2-git-send-email-jagan@amarulasolutions.com>
References: <1512673460-7865-1-git-send-email-jagan@amarulasolutions.com>
 <1512673460-7865-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAGb2v671Gra_Fq3Oa96zsQVeABxu0VKRyzVsiba93s5j+WqboA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 3:04 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Add reg_drivevbus regualtor for boards which are using
> external regulator to drive the OTG VBus through N_VBUSEN
> PMIC pin.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - New patch
>
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> index ff8af52..e5eae8b 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -146,5 +146,10 @@
>                         regulator-max-microvolt = <3000000>;
>                         regulator-name = "rtc-ldo";
>                 };
> +
> +               reg_drivevbus: drivevbus {

Could you keep the nodes in alphabetical order please?

Thanks
ChenYu

> +                       regulator-name = "drivevbus";
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.7.4
>

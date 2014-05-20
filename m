From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 23:21:40 -0700
Subject: [PATCH v2 09/10] ARM: STi: DT: STiH415: 415 DT Entry for clockgen
 A9
In-Reply-To: <1400073858-28912-10-git-send-email-gabriel.fernandez@linaro.org>
References: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
 <1400073858-28912-10-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <CAOesGMhH0B80mjH3w9nVa1CWxST2HVpyDZjjfX4koYgDaPYK2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 6:24 AM, Gabriel FERNANDEZ
<gabriel.fernandez@st.com> wrote:
> Patch adds DT entries for clockgen A9
>
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  arch/arm/boot/dts/stih415-clock.dtsi | 48 +++++++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/stih415-clock.dtsi
> index 8618851..5d161ee 100644
> --- a/arch/arm/boot/dts/stih415-clock.dtsi
> +++ b/arch/arm/boot/dts/stih415-clock.dtsi
> @@ -24,15 +24,6 @@
>                 };
>
>                 /*
> -                * ARM Peripheral clock for timers
> -                */
> -               arm_periph_clk: arm_periph_clk {
> -                       #clock-cells = <0>;
> -                       compatible = "fixed-clock";
> -                       clock-frequency = <500000000>;
> -               };
> -
> -               /*
>                  * ClockGenAs on SASG1
>                  */
>                 clockgenA at fee62000 {
> @@ -499,5 +490,44 @@
>                                                 /* Remaining outputs unused */
>                         };
>                 };
> +
> +               /*
> +                * A9 PLL
> +                */
> +               clockgenA9 {

This is a somewhat odd node name. We usually don't use caps mixed like
this. Also, the node should have a unit address (same as the address
portion of the reg value).

clockgen-a9 would be a more natural one.

> +                       reg = <0xfdde00d8 0x70>;
> +
> +                       CLOCKGEN_A9_PLL: CLOCKGEN_A9_PLL {

I'm really not a fan of the all-caps node names you guys are using.
Please switch to lower case like most other platforms. Just as in C,
we tend to keep all-caps to be used for constants and preprocessor
stuff.


-Olof

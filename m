From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 Aug 2014 22:08:11 +0800
Subject: [PATCH] ARM: dts: sun6i: Add #address-cells & #size-cells to i2c
 node
In-Reply-To: <1408456982-27021-1-git-send-email-ijc@hellion.org.uk>
References: <1408456982-27021-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <CAGb2v65Lg3cSGgbFwwJPt6SUhyoD3zp2Zuvmf_otdhTBF5y1TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 10:03 PM, Ian Campbell <ijc@hellion.org.uk> wrote:
> This fixes:
>   DTC     arch/arm/boot/dts/sun6i-a31-hummingbird.dtb
> Warning (reg_format): "reg" property in /soc at 01c00000/i2c at 01c2b400/rtc at 51 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc at 01c00000/i2c at 01c2b400/rtc at 51
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc at 01c00000/i2c at 01c2b400/rtc at 51

I submitted a fix for this just before the merge window.
I don't know why it didn't get into 3.17. Maxime did send a pull request for it.

See: https://patchwork.kernel.org/patch/4595851/

>
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 44b07e5..5bc769f 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -680,6 +680,8 @@
>                         clock-frequency = <100000>;
>                         resets = <&apb2_rst 2>;
>                         status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
>                 };
>
>                 i2c3: i2c at 01c2b800 {
> --
> 2.0.1
>

From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Nov 2015 11:59:26 +0800
Subject: [PATCH v3 3/3] ARM: dts: sun4i: gemei-g9: Enable sun4i audio
 codec support
In-Reply-To: <1446832486-32319-4-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
 <1446832486-32319-4-git-send-email-plaes@plaes.org>
Message-ID: <CAGb2v66uG-0EgVR=5SS4Lk-y5mX9v3Z39xP+0f7u7BfYq-b1yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 7, 2015 at 1:54 AM, Priit Laes <plaes@plaes.org> wrote:
> Gemei G9 has internal speakers and headphone jack. Audio switching
> from internal speakers to headphones is automatically handled by
> extra FT2012Q audio amplifier chip that works out of the box.

Nice that it works out of the box. The FEX file does mention:

audio_pa_ctrl   = port:PH15<1><default><default><0>

So either it is floating or pulled up by default? Since it works
now I don't see any reason to block it. On the other hand once
that binding is introduced it would be nice to add it for power
management reasons.

Acked-by: Chen-Yu Tsai <wens@csie.org>

> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
> Changes since v2:
>  - Dropped routing property.
>
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> index 16c1a67..1d73a98 100644
> --- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> @@ -65,12 +65,15 @@
>  /*
>   * TODO:
>   *   2x cameras via CSI
> - *   audio
> + *   audio input
>   *   AXP battery management
>   *   NAND
>   *   OTG
>   *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
>   */
> +&codec {
> +       status = "okay";
> +};
>
>  &cpu0 {
>         cpu-supply = <&reg_dcdc2>;
> --
> 2.6.3
>

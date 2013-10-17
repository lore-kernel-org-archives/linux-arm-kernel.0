From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 16 Oct 2013 21:32:51 -0700
Subject: [RESEND PATCH 3/4] ARM: dts: bcm281xx: Add i2c busses
In-Reply-To: <1381960909-1735-4-git-send-email-tim.kryger@linaro.org>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-4-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYqqxLevwM6dRpGUnfCgF2qZ_NVTDYTzKoFg+zbOPggfMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,
 This patch does not work as it relies on the yet-unmerged clock code
for bcm11351. This patch does not apply to -rc, and when tweaked it
does not compile as it references  non-existent bsc_clks.
 Has the clk patches been submitted yet ? Applying this will have to
wait until those have been accepted.

 thanks,
   csd


On Wed, Oct 16, 2013 at 3:01 PM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Add the DTS nodes for all the i2c busses in the SoC.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 1246885..4bfd7e3 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -146,6 +146,46 @@
>                 status = "disabled";
>         };
>
> +       i2c at 3e016000 {
> +               compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
> +               reg = <0x3e016000 0x80>;
> +               interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&bsc1_clk>;
> +               status = "disabled";
> +       };
> +
> +       i2c at 3e017000 {
> +               compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
> +               reg = <0x3e017000 0x80>;
> +               interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&bsc2_clk>;
> +               status = "disabled";
> +       };
> +
> +       i2c at 3e018000 {
> +               compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
> +               reg = <0x3e018000 0x80>;
> +               interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&bsc3_clk>;
> +               status = "disabled";
> +       };
> +
> +       i2c at 3500d000 {
> +               compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
> +               reg = <0x3500d000 0x80>;
> +               interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&pmu_bsc_clk>;
> +               status = "disabled";
> +       };
> +
>         clocks {
>                 bsc1_clk: bsc1 {
>                         compatible = "fixed-clock";
> --
> 1.8.0.1
>
>

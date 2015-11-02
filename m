From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 2 Nov 2015 21:25:23 +0900
Subject: [PATCH 1/2] arm64: dts: exynos7: Add pmic s2mps15 device tree node
In-Reply-To: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
References: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAJKOXPfrvuH8t3Pkf2Qt8VEfMR3qOeFKHrG0i3qUf94BR1y2tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-02 19:04 GMT+09:00 Alim Akhtar <alim.akhtar@samsung.com>:
> This patch add pmic (s2mps15) node of espresso board,

This patch adds PMIC (S2MPS15)...

> which includes addition of regulators and pmic-clk sub-nodes.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> This patch should go in after driver side changes [1] lands.
> [1]-> https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg47736.html

Eh? Why? Usually there is not such requirement.

>
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  349 +++++++++++++++++++++++
>  1 file changed, 349 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 838a3626dac1..8ce04a0ec928 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -53,6 +53,355 @@
>         status = "okay";
>  };
>
> +&hsi2c_4 {
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <200000>;
> +       status = "okay";
> +
> +       s2mps15_pmic at 66 {
> +               compatible = "samsung,s2mps15-pmic";
> +               reg = <0x66>;
> +               interrupts = <2 0>;
> +               interrupt-parent = <&gpa0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_irq>;
> +               wakeup-source;
> +
> +               s2mps15_osc: clocks {
> +                       compatible = "samsung,s2mps13-clk";
> +                       #clock-cells = <1>;
> +                       clock-output-names = "s2mps13_ap", "s2mps13_cp",
> +                               "s2mps13_bt";
> +               };

Don't you want to use one of these clocks for s3c-rtc (&rtc node)?

> +
> +               regulators {
> +                       ldo1_reg: LDO1 {
> +                               regulator-name = "vdd_ldo1";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <900000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo2_reg: LDO2 {
> +                               regulator-name = "vdd_ldo2";
> +                               regulator-min-microvolt = <1620000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <125>;
> +                               regulator-always-on;
> +                       };
> +
> +                       ldo3_reg: LDO3 {
> +                               regulator-name = "vdd_ldo3";
> +                               regulator-min-microvolt = <1620000>;
> +                               regulator-max-microvolt = <1980000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo4_reg: LDO4 {
> +                               regulator-name = "vdd_ldo4";
> +                               regulator-min-microvolt = <800000>;
> +                               regulator-max-microvolt = <1110000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo5_reg: LDO5 {
> +                               regulator-name = "vdd_ldo5";
> +                               regulator-min-microvolt = <1620000>;
> +                               regulator-max-microvolt = <1980000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo6_reg: LDO6 {
> +                               regulator-name = "vdd_ldo6";
> +                               regulator-min-microvolt = <2250000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo7_reg: LDO7 {
> +                               regulator-name = "vdd_ldo7";
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1150000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo8_reg: LDO8 {
> +                               regulator-name = "vdd_ldo8";
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo9_reg: LDO9 {
> +                               regulator-name = "vdd_ldo9";
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo10_reg: LDO10 {
> +                               regulator-name = "vdd_ldo10";
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1000000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo11_reg: LDO11 {
> +                               regulator-name = "vdd_ldo11";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1300000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo12_reg: LDO12 {
> +                               regulator-name = "vdd_ldo12";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1300000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo13_reg: LDO13 {
> +                               regulator-name = "vdd_ldo13";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1300000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo14_reg: LDO14 {
> +                               regulator-name = "vdd_ldo14";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo15_reg: LDO15 {
> +                               regulator-name = "vdd_ldo15";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <2275000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo16_reg: LDO16 {
> +                               regulator-name = "vdd_ldo16";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo17_reg: LDO17 {
> +                               regulator-name = "vdd_ldo17";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo18_reg: LDO18 {
> +                               regulator-name = "vdd_ldo18";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <2275000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo19_reg: LDO19 {
> +                               regulator-name = "vdd_ldo19";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo20_reg: LDO20 {
> +                               regulator-name = "vdd_ldo20";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <2275000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo21_reg: LDO21 {
> +                               regulator-name = "vdd_ldo21";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo22_reg: LDO22 {
> +                               regulator-name = "vdd_ldo22";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo23_reg: LDO23 {
> +                               regulator-name = "vdd_ldo23";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <2275000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo24_reg: LDO24 {
> +                               regulator-name = "vdd_ldo24";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo25_reg: LDO25 {
> +                               regulator-name = "vdd_ldo25";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3375000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo26_reg: LDO26 {
> +                               regulator-name = "vdd_ldo26";
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1470000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       ldo27_reg: LDO27 {
> +                               regulator-name = "vdd_ldo27";
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <2275000>;
> +                               regulator-always-on;
> +                               regulator-enable-ramp-delay = <125>;
> +                       };
> +
> +                       buck1_reg: BUCK1 {
> +                               regulator-name = "vdd_mif";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck2_reg: BUCK2 {
> +                               regulator-name = "vdd_atlas";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck3_reg: BUCK3 {
> +                               regulator-name = "vdd_apollo";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck4_reg: BUCK4 {
> +                               regulator-name = "vdd_int";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck5_reg: BUCK5 {
> +                               regulator-name = "vdd_buck5";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1300000>;
> +                               regulator-always-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck6_reg: BUCK6 {
> +                               regulator-name = "vdd_g3d";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1400000>;
> +                               regulator-always-on;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck7_reg: BUCK7 {
> +                               regulator-name = "vdd_buck7";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1500000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck8_reg: BUCK8 {
> +                               regulator-name = "vdd_buck8";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <1500000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck9_reg: BUCK9 {
> +                               regulator-name = "vdd_buck9";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2100000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +
> +                       buck10_reg: BUCK10 {
> +                               regulator-name = "vdd_buck10";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };

All of these ldo3 and bucks in vendor tree for Espresso board have
ramp delay of 12000. Also they don't have enable-ramp-delay set and
voltages sometimes differ. I don't have S2MPS15 datasheet so I don't
know what is the true value... I'll leave it up to you but it looks
suspicious.

> +               };
> +       };
> +};

What will be the benefit of defining all of these regulators if they
are always on and without consumers? No one will disable them, no one
will change the voltage. Please provide some consumers.

Best regards,
Krzysztof

From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 01 Oct 2014 16:00:34 +0200
Subject: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
In-Reply-To: <01.09.14890.83F4B245@epcpsbge5.samsung.com>
References: <01.09.14890.83F4B245@epcpsbge5.samsung.com>
Message-ID: <1831792.g28ajrp9B5@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, October 01, 2014 12:47:52 AM YUVARAJ CD wrote:

> Since I am out of station, i dont have an access to my work set up.
> Can you send me the dts entries of sd crad and their corresponding regulator entries?

>From arch/arm/boot/dts/exynos5420-arndale-octa.dts:

...
        mmc at 12200000 {
                status = "okay";
                broken-cd;
                supports-highspeed;
                card-detect-delay = <200>;
                samsung,dw-mshc-ciu-div = <3>;
                samsung,dw-mshc-sdr-timing = <0 4>;
                samsung,dw-mshc-ddr-timing = <0 2>;
                pinctrl-names = "default";
                pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
                vmmc-supply = <&ldo10_reg>;

                slot at 0 {
                        reg = <0>;
                        bus-width = <8>;
                };
        };

        mmc at 12220000 {
                status = "okay";
                supports-highspeed;
                card-detect-delay = <200>;
                samsung,dw-mshc-ciu-div = <3>;
                samsung,dw-mshc-sdr-timing = <2 3>;
                samsung,dw-mshc-ddr-timing = <1 2>;
                pinctrl-names = "default";
                pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
                vmmc-supply = <&ldo10_reg>;

                slot at 0 {
                        reg = <0>;
                        bus-width = <4>;
                };
        };
...
                                ldo10_reg: LDO10 {
                                        regulator-name = "PVDD_PRE_1V8";
                                        regulator-min-microvolt = <1800000>;
                                        regulator-max-microvolt = <1800000>;
                                        regulator-always-on;
                                };
...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

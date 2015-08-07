From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Aug 2015 14:16:12 -0300
Subject: could not get clock /usdhc1_pwrseq:ext_clock(0)
Message-ID: <CAOMZO5BFSBjLNDuEVrdANU9Og1tttawp=a3vLCKFBJok95=r0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When booting linux-next 20150807 on a imx6q-cuboxi I see the following
error coming from __of_clk_get_by_name():

[    1.674167] ERROR: could not get clock /usdhc1_pwrseq:ext_clock(0)

The ext_clock clock is passed in the imx6qdl-microsom.dtsi:

    usdhc1_pwrseq: usdhc1_pwrseq {
        compatible = "mmc-pwrseq-simple";
        reset-gpios = <&gpio5 26 GPIO_ACTIVE_LOW>,
                  <&gpio6 0 GPIO_ACTIVE_LOW>;
        clocks = <&clk_sdio>;
        clock-names = "ext_clock";
    };

, where:

    clk_sdio: sdio-clock{
        compatible = "gpio-gate-clock";
        #clock-cells = <0>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_microsom_brcm_osc>;
        enable-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
    };

This used to work earlier, but I haven't bisected it yet.

Does anyone have an idea as to why __of_clk_get_by_name() fail in this case?

Thanks,

Fabio Estevam

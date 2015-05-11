From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 May 2015 10:46:10 -0300
Subject: [PATCH v2] ARM: dts: cubox-i: add support for Broadcom
 Wifi/Bluetooth devices
In-Reply-To: <20150511130016.GE9347@dragon>
References: <1430932810-28756-1-git-send-email-festevam@gmail.com>
 <20150511130016.GE9347@dragon>
Message-ID: <CAOMZO5Cy1uhbqSfRKw_K++VhTQW7Z29GwKNAiLgB_UrF4YG9-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, May 11, 2015 at 10:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> One of the device tree maintainers doesn't like "clocks" container.
> Since you're not using generic node name for child clock, the container
> can just be saved.

Just to make sure I understand your suggestion: would you like the
clock nodes to look like this?

    oscillator {
        clk_sdio: sdio-clock {
            compatible = "gpio-gate-clock";
            #clock-cells = <0>;
            pinctrl-names = "default";
            pinctrl-0 = <&pinctrl_microsom_brcm_osc>;
            enable-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
        };
    };

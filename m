From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Apr 2018 11:16:44 -0300
Subject: [PATCH v3] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
In-Reply-To: <20180405070939.22245-1-lukma@denx.de>
References: <20180405070939.22245-1-lukma@denx.de>
Message-ID: <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Thu, Apr 5, 2018 at 4:09 AM, Lukasz Majewski <lukma@denx.de> wrote:

> +       reg_audio: regulator-audio {
> +               compatible = "regulator-fixed";
> +               regulator-name = "sgtl5000-supply";
> +               gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };

sgtl5000 has 3 supplies: VDDD, VDDIO, VDDA.

Which supply does this reg_audio supply to the chip?

Can't you use any of the existing sgtl5000 regulator bindings to
describe this supply?

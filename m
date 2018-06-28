From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 21:39:37 -0700
Subject: [PATCH 2/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM
 nodes
In-Reply-To: <20180628042424.12664-3-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
 <20180628042424.12664-3-andrew.smirnov@gmail.com>
Message-ID: <CAHQ1cqHpX_nz+xyyPg30kXsn2oTp2BBzk-qpCi3z3kezg1PTWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 9:24 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> ZII's RDU1s come with two EEPROMs attached to RAVE SP. Add

Ugh, the description should read RDU2, not RDU1. Will fix in v2,
tomorrow. Sorry about that.

Thanks,
Andrey Smirnov

> corresponding nodes to make them availible.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy at gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 19a075aee19e..e4630481d951 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -320,10 +320,28 @@
>         rave-sp {
>                 compatible = "zii,rave-sp-rdu2";
>                 current-speed = <1000000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
>
>                 watchdog {
>                         compatible = "zii,rave-sp-watchdog";
>                 };
> +
> +               eeprom at a3 {
> +                       compatible = "zii,rave-sp-eeprom";
> +                       reg = <0xa3 0x4000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       zii,eeprom-name = "dds-eeprom";
> +               };
> +
> +               eeprom at a4 {
> +                       compatible = "zii,rave-sp-eeprom";
> +                       reg = <0xa4 0x4000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       zii,eeprom-name = "main-eeprom";
> +               };
>         };
>  };
>
> --
> 2.17.1
>

From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 11 Mar 2014 22:48:22 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIEFSTTogZHRzOiBpbXgyNS1wZGs6IEFkZCBhdWRp?=
 =?UTF-8?B?byBzdXBwb3J0?=
In-Reply-To: <1394562247-14898-2-git-send-email-fabio.estevam@freescale.com>
References: <1394562247-14898-1-git-send-email-fabio.estevam@freescale.com>
 <1394562247-14898-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1394563702.163280550@f196.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 11 ????? 2014, 15:24 -03:00 ?? Fabio Estevam <fabio.estevam@freescale.com>:
> mx25pdk has a sgtl5000 codec connected to the I2C1 port.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx25-pdk.dts | 76 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
> index 7a6d21f..ca3fea5 100644
> --- a/arch/arm/boot/dts/imx25-pdk.dts
> +++ b/arch/arm/boot/dts/imx25-pdk.dts
> @@ -34,9 +34,48 @@
>  			gpio = <&gpio2 3 0>;
>  			enable-active-high;
>  		};
> +
> +		reg_2p5v: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "2P5V";
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2500000>;
> +			regulator-always-on;

"regulator-always-on" for fixed regulator without GPIO do nothing.

---

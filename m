From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 15 Jul 2013 19:19:01 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyMS8yMl0gRFQ6IEFkZCBiYXNpYyBzdXBwb3J0IGZvciBp?=
 =?UTF-8?B?bXgzNS1iYXNlZCBkZXZpY2VzLg==?=
In-Reply-To: <1373900227-341-22-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-22-git-send-email-denis@eukrea.com>
Message-ID: <1373901541.255544938@f148.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
...
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> new file mode 100644
> index 0000000..012c1a3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
...
> +		emi at 80000000 { /* External Memory Interface */
> +			compatible = "fsl,emi", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x80000000 0x40000000>;
> +			ranges;
> +
> +			nand: nand at bb000000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
> +				reg = <0xbb000000 0x2000>;
> +				interrupts = <33>;
> +				status = "disabled";
> +			};
> +		};

WEIM driver can (should) be used here.
See the example of usage in imx27.dtsi.

---

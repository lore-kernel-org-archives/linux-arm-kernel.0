From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 15:55:11 +0100
Subject: [PATCH 2/5] ARM:dts:imx6:phyFLEX: Enable gpmi in module file
In-Reply-To: <1415971946-48975-3-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
 <1415971946-48975-3-git-send-email-c.hemp@phytec.de>
Message-ID: <1445555.ZBLGLeHvnl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 14:32:23 Christian Hemp wrote:
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -91,7 +91,7 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_gpmi_nand>;
>         nand-on-flash-bbt;
> -       status = "disabled";
> +       status = "okay";
>  };
> 

No need for the property unless you are overriding a 'status="disabled"'
from another file. Just remove this property here.

	Arnd

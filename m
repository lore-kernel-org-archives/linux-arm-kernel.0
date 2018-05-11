From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 11 May 2018 02:45:30 +0200 (CEST)
Subject: [PATCH 2/3] ARM: dts: imx28: Remove unit-address from pinctrl
In-Reply-To: <1525997810-10964-2-git-send-email-festevam@gmail.com>
References: <1525997810-10964-1-git-send-email-festevam@gmail.com>
 <1525997810-10964-2-git-send-email-festevam@gmail.com>
Message-ID: <435135292.243569.1525999530960@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 11. Mai 2018 um 02:16 geschrieben:
> 
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove unit-address and reg property from pinctrl subnodes to fix
> the following DTC warnings with W=1:
> 
> arch/arm/boot/dts/imx28-apf28dev.dtb: Warning (unique_unit_address): /apb at 80000000/apbh at 80000000/pinctrl at 80018000/hog at 0: duplicate unit-address (also used in node /apb at 80000000/apbh at 80000000
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts           |   9 +-
>  arch/arm/boot/dts/imx28-apx4devkit.dts         |  12 +-
>  arch/arm/boot/dts/imx28-cfa10036.dts           |  12 +-
>  arch/arm/boot/dts/imx28-cfa10037.dts           |   6 +-
>  arch/arm/boot/dts/imx28-cfa10049.dts           |  36 ++---
>  arch/arm/boot/dts/imx28-cfa10055.dts           |  12 +-
>  arch/arm/boot/dts/imx28-cfa10056.dts           |   9 +-
>  arch/arm/boot/dts/imx28-cfa10057.dts           |   9 +-
>  arch/arm/boot/dts/imx28-cfa10058.dts           |   6 +-
>  arch/arm/boot/dts/imx28-duckbill-2-485.dts     |  12 +-
>  arch/arm/boot/dts/imx28-duckbill-2-enocean.dts |  15 +-
>  arch/arm/boot/dts/imx28-duckbill-2-spi.dts     |  15 +-
>  arch/arm/boot/dts/imx28-duckbill-2.dts         |  12 +-
>  arch/arm/boot/dts/imx28-duckbill.dts           |   9 +-
>  arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts   |   3 +-
>  arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts   |   3 +-
>  arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi   |  24 ++--
>  arch/arm/boot/dts/imx28-evk.dts                |  12 +-
>  arch/arm/boot/dts/imx28-m28cu3.dts             |   9 +-
>  arch/arm/boot/dts/imx28-m28evk.dts             |   6 +-
>  arch/arm/boot/dts/imx28-sps1.dts               |   3 +-
>  arch/arm/boot/dts/imx28-ts4600.dts             |   3 +-
>  arch/arm/boot/dts/imx28-tx28.dts               |  33 ++---
>  arch/arm/boot/dts/imx28.dtsi                   | 191 ++++++++-----------------
>  24 files changed, 153 insertions(+), 308 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index c4fadbc..53ed2e2 100644
> ...
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 9ad8d35..8f46b1f 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -169,14 +169,11 @@
>  			};
>  
>  			pinctrl: pinctrl at 80018000 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  				compatible = "fsl,imx28-pinctrl", "simple-bus";
>  				reg = <0x80018000 0x2000>;
>  
> -				gpio0: gpio at 0 {
> +				gpio0: gpio0 {
>  					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
> -					reg = <0>;
>  					interrupts = <127>;
>  					gpio-controller;
>  					#gpio-cells = <2>;
> @@ -184,9 +181,8 @@
>  					#interrupt-cells = <2>;
>  				};

i'm not sure, but it looked to me like a proper way to address the gpio banks before.

Regards
Stefan

>  
> -				gpio1: gpio at 1 {
> +				gpio1: gpio1 {
>  					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
> -					reg = <1>;
>  					interrupts = <126>;
>  					gpio-controller;
>  					#gpio-cells = <2>;
> @@ -194,9 +190,8 @@
>  					#interrupt-cells = <2>;
>  				};
>

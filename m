From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 May 2016 18:38:49 +0300
Subject: [PATCH v2 11/23] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <1463728214-13838-12-git-send-email-geert+renesas@glider.be>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
 <1463728214-13838-12-git-send-email-geert+renesas@glider.be>
Message-ID: <e0a1fbc1-ac95-2c79-65ed-d0328679bb8a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/20/2016 10:10 AM, Geert Uytterhoeven wrote:

> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.
> ---
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> index 2c82dab2b6f45f9c..b3f0ac4b99bd5a3d 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
[...]
> @@ -127,7 +127,7 @@
>  		};
>  	};
>
> -	i2c2: i2c at 2 {
> +	i2c2: i2c2 {

    Not "i2c-2" as in the other patches?

>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "i2c-gpio";

MBR, Sergei

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 22 May 2012 16:13:48 +0200
Subject: [PATCH v3 3/3] ARM: dts: add nodes for atmel hsmci controllers
 for atmel platforms
In-Reply-To: <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120522141348.GC3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:09 Tue 22 May     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add nodes for mci controllers.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9g20.dtsi     |   12 ++++++++++++
>  arch/arm/boot/dts/at91sam9g25ek.dts    |   16 ++++++++++++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi     |   24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |   17 +++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5.dtsi      |   24 ++++++++++++++++++++++++
>  5 files changed, 93 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 773ef48..6a28bfe 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -197,6 +197,18 @@
>  				interrupts = <10 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc at fffa800 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xfffa800 0x600>;
> +				interrupts = <9 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
this need to be in 9260.dtsi

if you add the board too plese add all of them
or seperate the commits

Best Regards,
J.

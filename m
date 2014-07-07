From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 7 Jul 2014 16:57:21 +0200
Subject: [PATCH v2 03/18] AT91: G45: DT: Declare a second ram controller
In-Reply-To: <1404743131-24569-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1404743131-24569-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404743131-24569-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140707145721.GC3113@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/07/2014 at 16:25:16 +0200, Maxime Ripard wrote :
> The G45 has two identical ram controller, that are defined as a single one,
> with two reg cells.
> 
> The proper way to support such a case is to have two separate DT nodes.
> 

This is also the case for the sam9263, please fix it there too.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index ace6bf197b70..6f648b85b725 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -75,8 +75,12 @@
>  
>  			ramc0: ramc at ffffe400 {
>  				compatible = "atmel,at91sam9g45-ddramc";
> -				reg = <0xffffe400 0x200
> -				       0xffffe600 0x200>;
> +				reg = <0xffffe400 0x200>;
> +			};
> +
> +			ramc1: ramc at ffffe600 {
> +				compatible = "atmel,at91sam9g45-ddramc";
> +				reg = <0xffffe600 0x200>;
>  			};
>  
>  			pmc: pmc at fffffc00 {
> -- 
> 2.0.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

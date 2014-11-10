From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Nov 2014 16:39:12 +0100
Subject: [PATCH 3/3] ARM: at91: sama5d4: Add SFR
In-Reply-To: <1415632471-14672-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1415632471-14672-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1415632471-14672-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141110153912.GU4068@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2014 at 16:14:31 +0100, Alexandre Belloni wrote :
> The sama4d4 has Special Function Registers that allow to manage DDR, OHCI, EBI
> and AIC interrupt redirection.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index e0157b0f075c..580486b056fc 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -826,6 +826,11 @@
>  				status = "disabled";
>  			};
>  
> +			sfr: sfr at f8028000 {
> +				compatible = "atmel,sama5d4-sfr", "syscon";
> +				reg = <0xf0038000 0x4000>;

Obviously, that should be reg = <0xf8028000 0x4000>, I'll fix it

> +			};
> +
>  			mmc1: mmc at fc000000 {
>  				compatible = "atmel,hsmci";
>  				reg = <0xfc000000 0x600>;
> -- 
> 2.1.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

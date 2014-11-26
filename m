From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 26 Nov 2014 11:13:48 +0800
Subject: [PATCH v2 3/3] ARM: at91: sama5d4: Add SFR
In-Reply-To: <1416933604-31446-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1416933604-31446-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5475456C.509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Alexandre

On 11/26/2014 12:40 AM, Alexandre Belloni wrote:
> The sama4d4 has Special Function Registers that allow to manage DDR, OHCI, EBI
> and AIC interrupt redirection.

Just a nitpick, It should be sama5d4, not sama4d4.

Best Regards,
Josh Wu

>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/boot/dts/sama5d4.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index e0157b0f075c..9e281e22d591 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -826,6 +826,11 @@
>   				status = "disabled";
>   			};
>   
> +			sfr: sfr at f8028000 {
> +				compatible = "atmel,sama5d4-sfr", "syscon";
> +				reg = <0xf8028000 0x4000>;
> +			};
> +
>   			mmc1: mmc at fc000000 {
>   				compatible = "atmel,hsmci";
>   				reg = <0xfc000000 0x600>;

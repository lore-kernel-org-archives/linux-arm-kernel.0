From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Tue, 08 Jul 2014 08:11:29 +0200
Subject: [PATCHv2 17/32] ARM: at91/dt: ge863-pro3: define crystals
 frequencies
In-Reply-To: <1404764629-29136-18-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404764629-29136-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404764629-29136-18-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53BB8B91.8020501@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
the slow crystal is not on the module "ge863-pro3", but it's usually on application board. So I think this clock should 
be in board dts.

Dne 7.7.2014 22:23, Alexandre Belloni napsal(a):
> Define Telit GE863-PRO3, AK signal CDU and Telit EVK-PRO3 main and slow
> crystals frequencies.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>   arch/arm/boot/dts/ge863-pro3.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
> index 230099bb31c8..a32fdbefbbd9 100644
> --- a/arch/arm/boot/dts/ge863-pro3.dtsi
> +++ b/arch/arm/boot/dts/ge863-pro3.dtsi
> @@ -19,6 +19,14 @@
>   			compatible = "atmel,osc", "fixed-clock";
>   			clock-frequency = <6000000>;
>   		};
> +
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <6000000>;
> +		};
>   	};
>
>   	ahb {
>

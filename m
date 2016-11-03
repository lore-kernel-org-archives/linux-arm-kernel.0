From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 3 Nov 2016 20:11:12 +0100
Subject: [PATCH] at91sam9g20.dtsi: set correct USB clock divisors
In-Reply-To: <1477503811-32697-1-git-send-email-yurovsky@gmail.com>
References: <1477503811-32697-1-git-send-email-yurovsky@gmail.com>
Message-ID: <20161103191112.abdqmf7tgmrhsgle@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/2016 at 10:43:31 -0700, Andrey Yurovsky wrote :
> The AT91SAM9G20 has different clock divisors from the otherwise similar
> AT91SAM9260. Set them in at91sam9g20.dtsi so that all AT91SAM9G20 users set up
> the USB host controller clocks correctly.
> 
> Signed-off-by: Andrey Yurovsky <yurovsky@gmail.com>
> ---
>  arch/arm/boot/dts/at91sam9g20.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index f593016..6c4488c 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -62,6 +62,10 @@
>  					atmel,clk-output-range = <0 133000000>;
>  					atmel,clk-divisors = <1 2 4 6>;
>  				};
> +
> +				usb: usbck {
> +					atmel,clk-divisors = <4 2 0 0>;
> +				};

Actually, I had a look at the datasheet and it still says the divisors
are 1, 2 and 4. There are existing board using USB and those divisors.
Can someone at Atmel confirm?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

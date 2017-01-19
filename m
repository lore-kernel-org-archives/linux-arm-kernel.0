From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Jan 2017 08:23:28 -0700
Subject: [PATCH] ARM: dts: at91: Enable DMA on sama5d4_xplained console
In-Reply-To: <20170119004658.32750-1-alexandre.belloni@free-electrons.com>
References: <20170119004658.32750-1-alexandre.belloni@free-electrons.com>
Message-ID: <1ae3beb4-cfd1-1c6d-8c59-c94c45e1ba42@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/01/2017 ? 17:46, Alexandre Belloni a ?crit :
> Enable DMA on usart3 to get a more reliable console. This is especially
> useful for automation and kernelci were a kernel with PROVE_LOCKING enabled
> is quite susceptible to character loss, resulting in tests failure.
> 
> Cc: stable <stable@vger.kernel.org> #v4.1+
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks,
Regards.

> ---
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index ed7fce297738..44d1171c7fc0 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -110,6 +110,8 @@
>  			};
>  
>  			usart3: serial at fc00c000 {
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
>  				status = "okay";
>  			};
>  
> 


-- 
Nicolas Ferre

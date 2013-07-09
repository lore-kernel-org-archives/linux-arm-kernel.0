From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 9 Jul 2013 18:07:28 +0200
Subject: [PATCH 1/7] serial: at91: correct definition from DMA to PDC
In-Reply-To: <1373351626-30143-2-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-2-git-send-email-elen.song@atmel.com>
Message-ID: <51DC3540.5010902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One little comment.

On 09/07/2013 08:33, Elen Song :

[..]

> @@ -19,9 +19,9 @@ Example:
>
>   	usart0: serial at fff8c000 {
>   		compatible = "atmel,at91sam9260-usart";
> -		reg = <0xfff8c000 0x4000>;
> -		interrupts = <7>;
> -		atmel,use-dma-rx;
> -		atmel,use-dma-tx;
> +		reg = <0xfff8c000 0x200>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;

This is not related to this patch topic: please remove.

> +		atmel,use-pdc-rx;
> +		atmel,use-pdc-tx;
>   	};

[..]

-- 
Nicolas Ferre

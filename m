From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 May 2016 17:57:17 +0200
Subject: [PATCH 3/3] tty/serial: atmel: add comment for the ring buffer
 size macro
In-Reply-To: <1463067456-6983-3-git-send-email-ludovic.desroches@atmel.com>
References: <1463067456-6983-1-git-send-email-ludovic.desroches@atmel.com>
 <1463067456-6983-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5734A7DD.8030705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/05/2016 17:37, Ludovic Desroches a ?crit :
> There is a macro named ATMEL_SERIAL_RINGSIZE which suggesting that it
> corresponds to the real size of the ring buffer. Let warn people that
> there is a factor of four since allocation size is
> sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks!

> ---
>  drivers/tty/serial/atmel_serial.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 6c1ec7d..8570163 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -108,6 +108,12 @@ struct atmel_uart_char {
>  	u16		ch;
>  };
>  
> +/*
> + * Be careful, the real size of the ring buffer is
> + * sizeof(atmel_uart_char) * ATMEL_SERIAL_RINGSIZE. It means that ring buffer
> + * can contain up to 1024 characters in PIO mode and up to 4096 characters in
> + * DMA mode.
> + */
>  #define ATMEL_SERIAL_RINGSIZE 1024
>  
>  /*
> 


-- 
Nicolas Ferre

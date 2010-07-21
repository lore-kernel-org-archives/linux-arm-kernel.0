From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 21 Jul 2010 13:11:52 +0400
Subject: [PATCH] serial: samsung.c: Add FRACVAL support for newer UART
In-Reply-To: <1277474119-6897-1-git-send-email-kgene.kim@samsung.com>
References: <1277474119-6897-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C46B9D8.7020504@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kukjin Kim wrote:

> From: Changhwan Youn <chaos.youn@samsung.com>

> FRACVAL register provides the same function as UDIVSLOT register which is
> the 1/16ths adjustment to the baud rate but the implementaiton is easier.
> To support UDIVSLOT register, UDIVSLOT table search is necessary though
> supporting FRACVAL only needs the index value of UDIVSLOT table.

> This patch implements the FRACVAL supports for the newer Samsung SoC UARTs.

> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
[...]
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index a9d6c56..09805c7 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -530,7 +530,7 @@ static int s3c24xx_serial_calcbaud(struct baud_calc *calc,
>  
>  	calc->clksrc = clksrc;
>  
> -	if (ourport->info->has_divslot) {
> +	if ((ourport->info->has_divslot) || (ourport->info->has_fracval)) {

    Parens around variables are not needed.


> @@ -755,7 +758,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  	wr_regl(port, S3C2410_UBRDIV, quot);
>  	wr_regl(port, S3C2410_UMCON, umcon);
>  
> -	if (ourport->info->has_divslot)
> +	if ((ourport->info->has_divslot) || (ourport->info->has_fracval))

    Here as well...

WBR, Sergei

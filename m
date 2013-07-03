From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Jul 2013 09:52:45 +0800
Subject: [PATCH 1/5] serial: imx: distinguish the imx6 uart from the others
In-Reply-To: <1372746628-20092-2-git-send-email-b32955@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-2-git-send-email-b32955@freescale.com>
Message-ID: <20130703015243.GD9145@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 02:30:24PM +0800, Huang Shijie wrote:
> @@ -801,7 +814,7 @@ static int imx_startup(struct uart_port *port)
>  		}
>  	}
>  
> -	if (is_imx21_uart(sport)) {
> +	if (is_imx21_uart(sport) || is_imx6_uart(sport)) {

Would it be better to use (!is_imx1_uart(sport)) here?  Thus when there
is another derivative of imx21-uart device to be added, we do not need
to touch this line again.

Shawn

>  		temp = readl(sport->port.membase + UCR3);
>  		temp |= IMX21_UCR3_RXDMUXSEL;
>  		writel(temp, sport->port.membase + UCR3);

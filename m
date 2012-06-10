From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Jun 2012 14:38:43 -0300
Subject: ARM: iMX: lockup with irqs disabled in drivers/tty/imx.c
In-Reply-To: <4FB8CFBB.2020004@cs.bris.ac.uk>
References: <4FB8CFBB.2020004@cs.bris.ac.uk>
Message-ID: <CAOMZO5AqJL6tHEJKr17utuP5frpU3W-bHvgg495GD8fN3D3jMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sun, May 20, 2012 at 8:04 AM, Michael McTernan
<Michael.McTernan.2001@cs.bris.ac.uk> wrote:

> Signed-off-by: Michael McTernan <Michael.McTernan.2001@cs.bris.ac.uk>
> diff -Naurp orig/imx.c fixed/imx.c
> --- orig/imx.c ?2012-05-20 10:37:20.320041462 +0100
> +++ fixed/imx.c 2012-05-20 11:18:28.512657377 +0100
> @@ -741,6 +741,9 @@ static int imx_startup(struct uart_port
> ? ? ? ?writel(temp, sport->port.membase + UCR1);
>
> ? ? ? ?temp = readl(sport->port.membase + UCR2);
> + ? ? ? if (!sport->have_rtscts) {
> + ? ? ? ? ? ? ? ? ? ? ? temp |= UCR2_IRTS;
> + ? ? ? }
> ? ? ? ?temp |= (UCR2_RXEN | UCR2_TXEN);
> ? ? ? ?writel(temp, sport->port.membase + UCR2);

Could you please re-submit this patch via git send-email and copy the
relevant lists and maintainers? (Hint: use ./scripts/get_maintainer.pl
)

You should also add kernel at pengutronix.de in Cc.

Regards,

Fabio Estevam

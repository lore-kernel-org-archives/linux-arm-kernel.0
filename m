From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 18:20:47 +0900
Subject: [PATCH] serial: samsung.c: Add FRACVAL support for newer UART
In-Reply-To: <4C46B9D8.7020504@ru.mvista.com>
References: <1277474119-6897-1-git-send-email-kgene.kim@samsung.com>
	<4C46B9D8.7020504@ru.mvista.com>
Message-ID: <008b01cb28b6$049fc6d0$0ddf5470$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
Hi ;-)

> Kukjin Kim wrote:
> 
> > From: Changhwan Youn <chaos.youn@samsung.com>
> 
> > FRACVAL register provides the same function as UDIVSLOT register which
is
> > the 1/16ths adjustment to the baud rate but the implementaiton is
easier.
> > To support UDIVSLOT register, UDIVSLOT table search is necessary though
> > supporting FRACVAL only needs the index value of UDIVSLOT table.
> 
> > This patch implements the FRACVAL supports for the newer Samsung SoC
> UARTs.
> 
> > Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> [...]
> > diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> > index a9d6c56..09805c7 100644
> > --- a/drivers/serial/samsung.c
> > +++ b/drivers/serial/samsung.c
> > @@ -530,7 +530,7 @@ static int s3c24xx_serial_calcbaud(struct baud_calc
*calc,
> >
> >  	calc->clksrc = clksrc;
> >
> > -	if (ourport->info->has_divslot) {
> > +	if ((ourport->info->has_divslot) || (ourport->info->has_fracval)) {
> 
>     Parens around variables are not needed.
> 
Yeah.

> 
> > @@ -755,7 +758,7 @@ static void s3c24xx_serial_set_termios(struct
uart_port
> *port,
> >  	wr_regl(port, S3C2410_UBRDIV, quot);
> >  	wr_regl(port, S3C2410_UMCON, umcon);
> >
> > -	if (ourport->info->has_divslot)
> > +	if ((ourport->info->has_divslot) || (ourport->info->has_fracval))
> 
>     Here as well...
> 
Yeah.

You're right.
But already re-submitted updated.

Please kindly find following URL.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/020713.html

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

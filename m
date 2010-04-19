From: ra7055@freescale.com (Herring Robert-RA7055)
Date: Mon, 19 Apr 2010 13:47:12 -0700
Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
In-Reply-To: <k2med82fe3e1004191340j5ff359d1q7a3470084b2d3ad2@mail.gmail.com>
References: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
	<k2med82fe3e1004191340j5ff359d1q7a3470084b2d3ad2@mail.gmail.com>
Message-ID: <DE2504B3A515524BBE6934369EFDC0DA0937E409@az33exm20.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur,

> -----Original Message-----
> From: Timur Tabi [mailto:timur.tabi at gmail.com] 
> Sent: Monday, April 19, 2010 3:40 PM
> To: Herring Robert-RA7055
> Cc: linux-arm-kernel at lists.infradead.org; 
> s.hauer at pengutronix.de; amit.kucheria at canonical.com
> Subject: Re: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
> 
> On Fri, Apr 16, 2010 at 2:35 PM, Rob Herring 
> <r.herring@freescale.com> wrote:
> 
> > +/* Serial ports */
> > +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> > +static struct imxuart_platform_data uart_pdata = {
> > +// ? ? .flags = IMXUART_HAVE_RTSCTS,
> 
> You forgot to run checkpatch.pl.  C++ comments are not allowed.

Yes I know. I'm only soliciting comments on the way I have structured adding MX53 to MX51 codebase.

> 
> > +#else /* !SERIAL_IMX */
> > +static inline void mxc_init_imx_uart(void)
> > +{
> > +}
> > +#endif /* SERIAL_IMX */
> 
> How about:
> 
> #define mxc_init_imx_uart() do { } while (0)

Just following existing code style in board-mx51_babbage.c.

Rob

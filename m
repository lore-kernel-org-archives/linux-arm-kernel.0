From: alan@linux.intel.com (Alan Cox)
Date: Tue, 26 May 2015 15:28:38 +0100
Subject: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
In-Reply-To: <1432545245.8736.5.camel@intel.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
 <1432545245.8736.5.camel@intel.com>
Message-ID: <1432650518.13900.72.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +#define UNIPHIER_UART_CHAR_FCR	3	/* Character / FIFO Control Register */
> > +#define UNIPHIER_UART_LCR_MCR	4	/* Line/Modem Control Register */
> > +#define   UNIPHIER_UART_LCR_SHIFT	8
> 
> Indentation problem, needs to be fixed.

If you are going to review a patch set at least look at the previous
reviews - the indentation was already discussed and is done that way to
show (as many drivers do) which are fields for which registers

> > +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
> > +{
> > +	int valshift = 0;
> 
> Perhaps unsigned int?

Why ? even if it mattered gcc is already realising that the value can
only be 0 or 8 and will be generating whatever works best for that.


Alan

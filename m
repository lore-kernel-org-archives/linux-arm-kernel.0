From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Tue, 26 May 2015 15:08:27 +0000
Subject: [PATCH v6] serial: 8250_uniphier: add UniPhier serial driver
In-Reply-To: <1432650518.13900.72.camel@linux.intel.com>
References: <1432525477-14051-1-git-send-email-yamada.masahiro@socionext.com>
 <1432545245.8736.5.camel@intel.com>
 <1432650518.13900.72.camel@linux.intel.com>
Message-ID: <1432652906.8736.44.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-26 at 15:28 +0100, Alan Cox wrote:
> > > +
> > > +#define UNIPHIER_UART_CHAR_FCR	3	/* Character / FIFO Control Register */
> > > +#define UNIPHIER_UART_LCR_MCR	4	/* Line/Modem Control Register */
> > > +#define   UNIPHIER_UART_LCR_SHIFT	8
> > 
> > Indentation problem, needs to be fixed.
> 
> If you are going to review a patch set at least look at the previous
> reviews - the indentation was already discussed and is done that way to
> show (as many drivers do) which are fields for which registers

This is not exactly the field, the way how to get the field.
In some cases it is even better to define something like
_LCR(x)  ((x) << 8)


> 
> > > +static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
> > > +{
> > > +	int valshift = 0;
> > 
> > Perhaps unsigned int?
> 
> Why ? even if it mattered gcc is already realising that the value can
> only be 0 or 8 and will be generating whatever works best for that.

It's not about how gcc does, it's about what assumptions can be made
from the reading of the source code. I think if we do a counter of shift
value it would be nice to set an unsigned type explicitly.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

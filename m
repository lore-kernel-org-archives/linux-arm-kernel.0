From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 11 Jul 2018 17:23:13 +0300
Subject: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180711144125.7d4e6a73@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
 <20180710111516.13b8c570@xhacker.debian>
 <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
 <20180711144125.7d4e6a73@xhacker.debian>
Message-ID: <d2ba8f992c272543d689d87006e99c3bcf343605.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-11 at 14:41 +0800, Jisheng Zhang wrote:
> On Tue, 10 Jul 2018 19:19:21 +0300 Andy Shevchenko wrote:

> > > +/*
> > > + * divisor = div(I) + div(F)
> > > + * "I" means integer, "F" means fractional
> > > + * quot = div(I) = clk / (16 * baud)
> > > + * frac = div(F) * 2^dlf_size
> > > + *
> > > + * let rem = clk % (16 * baud)
> > > + * we have: div(F) * (16 * baud) = rem
> > > + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) /
> > > (16
> > > * baud)
> > > + */

> > > +	quot = p->uartclk / (16 * baud);
> > > +	rem = p->uartclk % (16 * baud);
> > > +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud

> My python coding skill is limited. So I wrote a simple c program to
> do the check for common clks and baudrate combination. All passed. I
> paste the code here:
> 

OK, I wrote test case in Python:
https://gist.github.com/andy-shev/5e980f1d752617ba814725248556ac19

Looks good to me.

Please, send v6 and assume my Reviewed-by for entire series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

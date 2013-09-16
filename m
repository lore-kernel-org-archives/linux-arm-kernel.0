From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Mon, 16 Sep 2013 10:17:31 +0200
Subject: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register
 access
In-Reply-To: <52358D71.2040905@kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
 <52358D71.2040905@kernel.org>
Message-ID: <201309161017.31846.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sunday 15 September 2013 12:35:29 Jonathan Cameron wrote:
> [...]
> > +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
> > +{
> > +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
> > +{ 
> > +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> > +}
> > +
>
> mxs_lradc_reg_write might be clearer?

I would prefer the shorter name. Due to long macro names and long function 
names the lines in the code below needs more and more line breaks which is 
IMHO less helpfull to read the code.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 27 Jul 2014 23:50:51 +0200
Subject: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
In-Reply-To: <53D56ABD.8080808@gmx.de>
References: <5068889.1KfVx3ksNo@wuerfel> <53D56ABD.8080808@gmx.de>
Message-ID: <1743122.0WWLup698P@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 27. Juli 2014, 23:10:21 schrieb Hartmut Knaack:
> Arnd Bergmann schrieb:
> > @@ -205,6 +217,9 @@ static void exynos_adc_v1_init_hw(struct exynos_adc
> > *info)> 
> >  	/* Enable 12-bit ADC resolution */
> >  	con1 |= ADC_V1_CON_RES;
> >  	writel(con1, ADC_V1_CON(info->regs));
> > 
> > +
> > +	/* set default touchscreen delay */
> 
> Any information about how many ?s/ms it is actually set with this value?

"ADC conversion is delayed by counting this value. Counting clock is pclk."
So, I guess here 10000 pclk ticks.


Heiko

> 
> > +	writel(10000, ADC_V1_DLY(info->regs));
> > 
> >  }
> >  

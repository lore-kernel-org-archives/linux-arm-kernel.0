From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 10 May 2014 00:57:09 +0200
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <1399654181.19276.2.camel@x220>
References: <2104342.rkElQpXtvM@phil> <3835735.0k9HAgQHzN@phil>
 <1399654181.19276.2.camel@x220>
Message-ID: <1454194.ZOZn9c4lf4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. Mai 2014, 18:49:41 schrieb Paul Bolle:
> > @@ -643,7 +654,8 @@ config MACH_RX1950
> > 
> >  	select PM_H1940 if PM
> >  	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
> >  	select S3C2440_XTAL_16934400
> > 
> > -	select S3C24XX_DCLK
> > +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> > +	select S3C24XX_COMMON_DCLK if COMMON_CLK
> 
> This looks like a typo. Did you mean S3C2410_COMMON_DCLK?

yep that is a typo, S3C2410_COMMON_DCLK is the correct one.

Heiko

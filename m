From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 8 Jan 2013 01:02:01 +0000
Subject: [v3 PATCH 05/12] spi/atmel_spi: update the dt support
In-Reply-To: <1357524362.4940.16.camel@joe-AO722>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
 <1357523413-27209-6-git-send-email-wenyou.yang@atmel.com>
 <1357524362.4940.16.camel@joe-AO722>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A05704A@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: 2013?1?7? 10:06
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas; plagnioj at jcrosoft.com; richard.genoud at gmail.com; Lin, JM
> Subject: Re: [v3 PATCH 05/12] spi/atmel_spi: update the dt support
> 
> On Mon, 2013-01-07 at 09:50 +0800, Wenyou Yang wrote:
> > To meet the different spi IP version of atmel SoC,
> > add more compatible "atmel,at91rm9200-spi", "atmel,at91sam9260-spi"
> > "atmel,at91sam9g45-spi", "atmel,at91sam9x5-spi" with different
> > config and devtype.
> 
> trivial comment:
> 
> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> []
> > @@ -230,11 +302,15 @@ struct atmel_spi_device {
> >   * register, but I haven't checked that it exists on all chips, and
> >   * this is cheaper anyway.
> >   */
> > -static bool atmel_spi_is_v2(void)
> > +static bool atmel_spi_is_v2(struct atmel_spi *as)
> 
> There's a comment that needs updating above this now
> 
> >  {
> > -	return !cpu_is_at91rm9200();
> > +	if (as->pdata->version == 2)
> > +		return true;
> > +	else
> > +		return false;
> 
> 	return as->pdata->version == 2;
> 
> is rather more readable to me

Thanks a lot for quick feedback.
I will change it next version.
> 

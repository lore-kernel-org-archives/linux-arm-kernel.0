From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 3 Apr 2013 05:09:53 +0000
Subject: [PATCH v7 06/14] spi/spi-atmel: add flag to controller data for
 lock operations
In-Reply-To: <20130401134613.GY18636@opensource.wolfsonmicro.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679163-3897-1-git-send-email-wenyou.yang@atmel.com>
 <20130401134613.GY18636@opensource.wolfsonmicro.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8CC7B@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: 2013?4?1? 21:46
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca;
> richard.genoud at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; Lin, JM;
> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v7 06/14] spi/spi-atmel: add flag to controller data for lock
> operations
> 
> On Tue, Mar 19, 2013 at 03:46:03PM +0800, Wenyou Yang wrote:
> 
> > +static void atmel_spi_lock(struct atmel_spi *as) {
> > +		spin_lock_irqsave(&as->lock, as->flags); }
> 
> Coding style.
I will change it in next version.

> 
> > -	spin_unlock(&as->lock);
> > +	atmel_spi_unlock(as);
> >  	msg->complete(msg->context);
> > -	spin_lock(&as->lock);
> > +	atmel_spi_lock(as);
> 
> This replaces non-irqsave versions with irqsave versions of the lock.
> Is this safe/correct?  If it is I'd have expected some sort of mention of it in the
> commit log.
I will add some commit log.

Best Regards,
Wenyou Yang

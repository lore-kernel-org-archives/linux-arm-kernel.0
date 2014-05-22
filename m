From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 17:08:56 +0100
Subject: [PATCH] mfd: axp20x: Remove unnecessary const qualifier from
 axp20x_supplies[]
In-Reply-To: <1400774373.21099.1.camel@joe-AO725>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
 <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
 <1400774373.21099.1.camel@joe-AO725>
Message-ID: <20140522160856.GJ19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > drivers/mfd/axp20x.c:159:3:
> >   warning: initialization discards ?const? qualifier from pointer target type
> >    .parent_supplies = axp20x_supplies,
> []
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> []
> > @@ -140,7 +140,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
> >  	.init_ack_masked	= true,
> >  };
> >  
> > -static const char * const axp20x_supplies[] = {
> > +static const char * axp20x_supplies[] = {
> >  	"acin",
> >  	"vin2",
> >  	"vin3",
> 
> Perhaps you're doing this the wrong way round.
> Maybe this definition should change.
> 
> include/linux/mfd/core.h:       const char              **parent_supplies;

Are you asking me, or telling me? :)

To be frank, I've never known what the double const means.  Care to
enlighten?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

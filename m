From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 5 Mar 2015 16:09:56 +0100
Subject: [PATCH v3 4/9] power: reset: Add AT91RM9200 reset driver
In-Reply-To: <20150304171758.GA8717@earth>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20150304171758.GA8717@earth>
Message-ID: <20150305150956.GT3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2015 at 18:17:58 +0100, Sebastian Reichel wrote :
> Hi,
> 
> On Wed, Mar 04, 2015 at 03:21:32PM +0100, Alexandre Belloni wrote:
> > AT91RM9200 uses the watchdog from the system timer to reset.
> > [...]
> > +	regmap_write(regmap_st, AT91_ST_WDMR,
> > +		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> > +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
> > +
> > +	mdelay(2000);
> 
> At pity that you have to write into two registers, otherwise you
> could have used the syscon-reboot driver.
> 

Exactly what I was thinking :)

> > [...]
> > +module_platform_driver(at91rm9200_reset_driver);
> 
> Apart from missing module metadata (MODULE_AUTHOR(),
> MODULE_LICENSE(), ...) the driver looks fine to me.
> 

I'll add those.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

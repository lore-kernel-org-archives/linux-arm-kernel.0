From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 22 Dec 2012 15:49:01 +0100
Subject: [PATCH v2 01/20] mmc: mvsdio: use slot-gpio infrastructure for
 write protect gpio
In-Reply-To: <20121222140529.GA12120@S2101-09.ap.freescale.net>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121222140529.GA12120@S2101-09.ap.freescale.net>
Message-ID: <20121222154901.14ecdb73@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

On Sat, 22 Dec 2012 22:05:32 +0800, Shawn Guo wrote:
> On Fri, Dec 21, 2012 at 03:49:00PM +0100, Thomas Petazzoni wrote:
> > @@ -831,8 +809,7 @@ out:
> >  			free_irq(gpio_to_irq(host->gpio_card_detect), host);
> >  			gpio_free(host->gpio_card_detect);
> >  		}
> > -		if (host->gpio_write_protect)
> > -			gpio_free(host->gpio_write_protect);
> > +		mmc_gpio_free_ro(mmc);
> 
> I posted a series[1] to save the call from error path and .remove().

Yes, I've seen this one. Would you mind if I send a followup patch
series that improves the mvsdio to use your new helper functions? I
would like to avoid having too many dependencies for patch series.

> PS. What's the merge path for these mmc patches?  I do not even see
> linux-mmc and Chris Ball on the Cc list.

The merge path remains to be figured out. For now, I've Cc'ed Nicolas
Pitre, who is referenced as the maintainer for the mvsdio driver, as
well as the Marvell maintainers Jason Cooper, Andrew Lunn and Gr?gory
Cl?ment. If a v3 is needed, I'll add linux-mmc and Chris Ball to the Cc
list. That said, the majority of the patch is mostly Marvell-specific,
so I guess it would be simpler if we could carry this through the
Marvell maintainers, and then through arm-soc, of course with the Ack
of the relevant MMC maintainers.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

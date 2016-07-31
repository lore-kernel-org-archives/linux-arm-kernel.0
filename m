From: joe@perches.com (Joe Perches)
Date: Sun, 31 Jul 2016 15:22:21 -0700
Subject: [PATCH v3] ARM: pxa: fix GPIO double shifts
In-Reply-To: <87shupxy50.fsf@belgarion.home>
References: <1469967435-23436-1-git-send-email-robert.jarzmik@free.fr>
 <1469997882.3998.136.camel@perches.com> <87shupxy50.fsf@belgarion.home>
Message-ID: <1470003741.3998.140.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-08-01 at 00:04 +0200, Robert Jarzmik wrote:
> Joe Perches <joe@perches.com> writes:
[]
> > These might be better without the automatic use of ret
> > 
> > 	return !gpio_get_value(CORGI_GPIO_AC_IN) ||
> > 	? ? ? ?!gpio_get_value(CORGI_GPIO_KEY_INT) ||
> > 	? ? ? ?!gpio_get_value(CORGI_GPIO_WAKEUP);
> Yeah, I thought about this when I made the patch.
> 
> I supposed it was written this way so that a printk was easier to add, that's
> why I didn't change the useless variable.
> 
> I have no strong opinion about this, so if you think it's worth it I can make
> the additional change.

Hi Robert. ?Your choice.

It was one of those, 'oh, bother' type of things but?
I think it's worth it for readability and consistency.

cheers, Joe

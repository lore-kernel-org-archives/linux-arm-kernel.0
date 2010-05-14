From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 20:34:14 +0900
Subject: PIPT cache handling on s5pv210 chip
In-Reply-To: <20100514104843.GG10339@n2100.arm.linux.org.uk>
References: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
	<00bc01caf351$5daf71c0$190e5540$%kim@samsung.com>
	<20100514104843.GG10339@n2100.arm.linux.org.uk>
Message-ID: <00ca01caf359$643defa0$2cb9cee0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> On Fri, May 14, 2010 at 07:36:47PM +0900, Kukjin Kim wrote:
> > In case of __vmalloc() with non-cacheable option, there may come some
> > malfunctions related to cache.
> 
> Practically, you are not allowed on ARMv6 or ARMv7 to create mappings
> which alias with differing memory types; that is 100% outlawed by the
> architecture spec, and there is NO mitigation for this.
> 
> It means that it is _illegal_ to use __vmalloc() with anything but a
> memory-like mapping protection.
> 
> There is mitigation for having different cacheability, but this is just
> a work-around while OSes like Linux work to remove the creation of
> aliases with differing cacheability attributes.  There's no guarantee
> that later ARMv7 or future CPUs will continue to operate predictably.
> 
> The same applies for ioremap() being used on SDRAM - and those who look
> at what's in my tree will notice that ioremap() has recently been made
> to fail when used on SDRAM for this very reason.

In case a driver starts the Memory_To_Peripheral DMA operation with the
memory area allotted by __vmalloc(,,no-cacheable), the driver can face some
problems caused by cache victims.

> Therefore, the above hack isn't going near mainline.

Nevertheless, I think so too.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

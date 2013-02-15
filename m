From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Feb 2013 10:18:01 +0000
Subject: [PATCH] arm: arch_timer: include linux/errno.h to declare ENXIO
In-Reply-To: <511D215C.2040807@wwwdotorg.org>
References: <1360778746-27809-1-git-send-email-swarren@wwwdotorg.org>
 <20130214121816.GA25537@e106331-lin.cambridge.arm.com>
 <511D215C.2040807@wwwdotorg.org>
Message-ID: <20130215101801.GI25537@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 05:39:40PM +0000, Stephen Warren wrote:
> On 02/14/2013 05:18 AM, Mark Rutland wrote:
> > On Wed, Feb 13, 2013 at 06:05:46PM +0000, Stephen Warren wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >>
> >> This fixes:
> >> arch/arm/kernel/arch_timer.c: In function ?arch_timer_sched_clock_init?:
> >> arch/arm/kernel/arch_timer.c:55:11: error: ?ENXIO? undeclared (first use in this function)
> ..
> > We should probably also add this to include/clocksource/arm_arch_timer.h and
> > drivers/clocksource/arm_arch_timer.c, as they both use errno values (though
> > currently these get included indirectly via a different path).
> 
> Ah yes, it should certainly be added to the header file then. Since both
> those .c files include that header, I guess there isn't much need to add
> it separately to the .c files though?
> 
> Do you want me to respin the patch, or will you just create one to add
> the include to the header?
> 

I think it makes sense to have the include in both the header and the .c file,
as they both use error codes explicitly. The header (and
drivers/clocksource/arm_arch_timer.c) seem to build for the moment, so they can
be fixed up later.

Arnd seems to have arrived at the same patch in his allyesconfig fix series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149856.html

I'm happy to see either version go in.

Thanks,
Mark.

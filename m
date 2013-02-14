From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 10:39:40 -0700
Subject: [PATCH] arm: arch_timer: include linux/errno.h to declare ENXIO
In-Reply-To: <20130214121816.GA25537@e106331-lin.cambridge.arm.com>
References: <1360778746-27809-1-git-send-email-swarren@wwwdotorg.org>
 <20130214121816.GA25537@e106331-lin.cambridge.arm.com>
Message-ID: <511D215C.2040807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 05:18 AM, Mark Rutland wrote:
> On Wed, Feb 13, 2013 at 06:05:46PM +0000, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This fixes:
>> arch/arm/kernel/arch_timer.c: In function ?arch_timer_sched_clock_init?:
>> arch/arm/kernel/arch_timer.c:55:11: error: ?ENXIO? undeclared (first use in this function)
..
> We should probably also add this to include/clocksource/arm_arch_timer.h and
> drivers/clocksource/arm_arch_timer.c, as they both use errno values (though
> currently these get included indirectly via a different path).

Ah yes, it should certainly be added to the header file then. Since both
those .c files include that header, I guess there isn't much need to add
it separately to the .c files though?

Do you want me to respin the patch, or will you just create one to add
the include to the header?

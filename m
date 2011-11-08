From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 09:00:36 +0000
Subject: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <04fc01cc9de4$11dc3410$35949c30$%kim@samsung.com>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <04fc01cc9de4$11dc3410$35949c30$%kim@samsung.com>
Message-ID: <20111108090036.GY12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 04:00:16PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Part 3 - the remaining stuff
> > 
> > These are patches which I've managed to get half way through before
> > getting - to be honest - totally hacked off with the code found in
> > various platforms (as mentioned in previous mails).
> > 
> > These platforms are broken as a result of the final patch in part 2,
> > and these patches move these platforms _towards_ a solution.  They
> > are not a complete solution though, but the start of the solution.
> > 
> > For instance, the Exynos4 and S5PV210 patches both consist of almost
> > a full solution -but- with the new function prototype missing because
> > there is _no_ local header file to put it in, and I'm damned well not
> > putting it in the remote plat-samsung/include/plat headers.
> > 
> Russell,
> 
> The new restart prototype for s5pv210 and exynos can be placed in their
> respective<mach/system.h>file.

No - mach/system.h will be removed once arch_idle is gone as well.  In
any case, this should not be in a mach/*.h file.  There should be a
header in the arch/arm/mach-* directory for functions and data structures
local _only_ to the files in that directory.

Please read my 'pet peaves' email, point 4.

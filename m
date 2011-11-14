From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 14 Nov 2011 19:01:59 +0000
Subject: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <20111111171650.GA4154@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <20111111171650.GA4154@n2100.arm.linux.org.uk>
Message-ID: <DF0F476B391FA8409C78302C7BA518B601FCDA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Nov 11, 2011 at 22:46:50, Russell King - ARM Linux wrote:
> On Sun, Nov 06, 2011 at 05:54:57PM +0000, Russell King - ARM Linux wrote:
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
> > The final set of platforms - touched neither by part 3 nor 4, are
> > broken by the final patch in part 2, and at present I have no plans
> > to fix them.  I would welcome patches to fix these which address the
> > issues raised in the "pet peaves" email (which is why I have no plans
> > to fix them.)
> 
> The list of platforms which are still broken (today) by part 2 of this
> series are:
> 
> arch/arm/mach-davinci/include/mach/system.h
> arch/arm/mach-gemini/include/mach/system.h
> arch/arm/mach-nomadik/include/mach/system.h
> arch/arm/mach-s3c2410/include/mach/system-reset.h
> arch/arm/mach-s3c64xx/include/mach/system.h
> arch/arm/mach-shmobile/include/mach/system.h
> arch/arm/mach-vt8500/include/mach/system.h
> arch/arm/plat-samsung/include/plat/system-reset.h
> arch/arm/plat-tcc/include/mach/system.h
> 
> which require assistance to get these into shape.
> 
> As I've already implied, I'm quite prepared to break these platforms at
> the next merge window for the greater good if there's no sign of
> maintainers willing to help sort them out - which will then ultimately
> result in them being deleted from mainline.

I just sent a patch for which gets reboot working on DaVinci.
I have used the arm_pm_restart hook for now. I am working on
moving the arch/arm/mach-davinci/common.h (and other local headers)
to mach-davinci folder but that needs updates to some drivers like
USB and GPIO as well. I expect to be finished in about a weeks time.

Thanks,
Sekhar

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2012 19:06:54 +0000
Subject: [PATCH 1/2][RFC] at91 : move pm.h header to include/mach
In-Reply-To: <4F057188.8080101@linaro.org>
References: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
 <4F048CD9.1050601@gmail.com> <20120104221036.GK11810@n2100.arm.linux.org.uk>
 <4F057188.8080101@linaro.org>
Message-ID: <20120106190654.GA13857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 10:46:48AM +0100, Daniel Lezcano wrote:
> On 01/04/2012 11:10 PM, Russell King - ARM Linux wrote:
> > On Wed, Jan 04, 2012 at 11:31:05AM -0600, Rob Herring wrote:
> >> This header should probably be named something more specific like
> >> at91_pm.h or at91_sdram.h. This will be needed to avoid name collisions
> >> with mach headers on a single kernel binary.
> > 
> > I think actually the idea that mach/*.h headers can be included by stuff
> > outside of arch/arm is something that we should deprecate, because it's
> > not going to be sane to make them all unique in this way.
> > 
> > Not only that but it prevents the .c files being built on other
> > architectures, and provides another reason why the .c file is tied to
> > a pariticular SoC - even if the same IP is used in a different SoC, it
> > can be used as a reason why not to reuse the .c file.
> > 
> > Let's not give people excuses not to share code!
> 
> As the pm.h file should be included from drivers/cpuidle/at91_idle.c,
> does it make sense to move
> 	arch/arm/mach-at91/pm.h to arch/arm/include/asm/at91_pm.h ?

Not really.  If code is being moved out of arch/arm, their dependent
headers should also be moved out of arch/arm as well.  It makes no
sense to move the code out of arch/arm into drivers if it still
requires headers only found in arch/arm to build.

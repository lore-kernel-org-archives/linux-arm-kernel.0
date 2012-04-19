From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 10:53:42 +0000
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <4F8FD80A.1020901@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <201204190857.19770.arnd@arndb.de> <4F8FD80A.1020901@st.com>
Message-ID: <201204191053.42955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Viresh Kumar wrote:
> On 4/19/2012 2:27 PM, Arnd Bergmann wrote:
> > My preference would be to have the whole series go through your tree
> > and move the implementation of the spear clock code to drivers/clk
> > in the process. This will reduce interdependencies between the spear
> > clock branch and other branches that have spear patches.
> 
> Atleast for now, SPEAr clock patches have dependency on earlier SPEAr patches
> for which i have already sent you pull request.

Ok, I see. This could also be resolved by making the clock branch a
superset of stuff that is in arm-soc, so that Mike would just have
to wait for all the dependencies from arm-soc to go upstream before
he asks Linus to pull the clock specific changes.

> So, this time atleast, these may go through your tree only.
> 
> You are talking about moving all clk files to drivers/clk or part of them
> (plat/clk-*.c or mach/clock.c)

I mean all of them.

> Also, i don't know what's the best way, but arch/arm/*spear* looks to be the
> better place for SPEAr clock stuff. As it shares lot of registers/macros
> with non-clock stuff. If we keep them in drivers/clk we have to include
> <mach/...> files.

There is a general tendencies to move stuff out of arch/arm into subsystem
specific directories. We've already done this for drivers/gpio,
drivers/pinctrl and some others, and I would like to see the same get done
for irqchip and clock. The main reason is so that we have all drivers for
the subsystem in one place, where a reader can compare them and they
are put into the subsystem maintainers's responsibility rather than the
platform maintainer. Obviously you still want both the subsystem and the
platform maintainer to review any patches to those files, but in my
experience this is done more consistently by sorting the files by
subsystem.

	Arnd

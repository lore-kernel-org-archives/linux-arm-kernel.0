From: horms@verge.net.au (Simon Horman)
Date: Sat, 4 Jan 2014 08:39:07 +0900
Subject: [BUG] shmobile build failure
In-Reply-To: <CAOesGMiZrfP1GkdNqxKTUHHynMMH2i2x+1dwmZeuJ37CcaDOrA@mail.gmail.com>
References: <20140102172413.GB7383@n2100.arm.linux.org.uk>
 <CAOesGMiZrfP1GkdNqxKTUHHynMMH2i2x+1dwmZeuJ37CcaDOrA@mail.gmail.com>
Message-ID: <20140103233904.GA11179@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:36:07AM -0800, Olof Johansson wrote:
> On Thu, Jan 2, 2014 at 9:24 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > allmodconfig and allyesconfig fail with this error:
> >
> > arch/arm/mach-shmobile/setup-rcar-gen2.c:21:32: fatal error: linux/clk/shmobile.h: No such file or directory
> >
> > My guess is that shmobile on its own doesn't build because of this.
> > Is there a screwed dependency between arm-soc and the clk git trees?
> 
> Yeah, I noticed this too but hadn't had a chance to report it yet --
> holidays followed by getting sick.
> 
> I'm guessing they have a dependency on clk rework that we haven't merged.
> 
> Simon?

Hi Olof,

sorry about that, I have indeed made an error with dependencies.

The problem is that the following is needed by the pull
request "Third Round of Renesas ARM Based SoC Updates for v3.14",
tagged as renesas-soc3-for-v3.14, which you have pulled (thanks!):

git://git.linaro.org/people/mturquette/linux.git clk-next-shmobile

However, unfortunately, I only included it in the pull request "Third Round
of Renesas ARM Based SoC DT Updates for v3.14", tagged as.

I believe you have subsequently noticed this.

Sorry for the mix up!

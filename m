From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 16 May 2013 07:02:35 -0700
Subject: [GIT PULL] OMAP PM cleanups for v3.10
In-Reply-To: <20130423175934.GA6728@quad.lixom.net> (Olof Johansson's message
 of "Tue, 23 Apr 2013 10:59:34 -0700")
References: <87ehej1ena.fsf@linaro.org> <20130410181452.GG10155@atomide.com>
 <20130423175934.GA6728@quad.lixom.net>
Message-ID: <87ppwrt43o.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Wed, Apr 10, 2013 at 11:14:52AM -0700, Tony Lindgren wrote:
>> Hi,
>> 
>> Added Olof to cc, I suggest Olof pull this directly as we're starting
>> to run out of time.
>
> Hi,
>
> I'm terribly sorry for dropping this one on the floor, in spite of repeated
> pings from Tony. :(
>
> If it wasn't for the fact that we're pushing back on some of the other
> late submissions I'd be open to taking this, but to be fair it makes
> more sense to merge it right after -rc1. The changes don't look like
> they're truly critical for 3.10, and you should still be able to use
> this as a base for your 3.11 changes, so hopefully this doesn't cause
> too much trouble.
>
> So, please resend right after the merge window closes.

Pull request below.  It is unchanged and merges cleanly with v3.10-rc1.

Kevin

The following changes since commit c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:

  Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/pm

for you to fetch changes up to 705814b5ea6ff69d4da8ad581c3da5d26d1eae83:

  ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5 (2013-04-09 10:53:06 -0700)

----------------------------------------------------------------
OMAP PM cleanups for v3.10

----------------------------------------------------------------
Santosh Shilimkar (4):
      ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
      ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
      ARM: OMAP4+: Make secondary_startup function name more consistent
      ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5

 arch/arm/mach-omap2/common.h              |  4 +-
 arch/arm/mach-omap2/omap-headsmp.S        |  8 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 69 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/omap-smp.c            |  6 +--
 arch/arm/mach-omap2/pm44xx.c              | 58 +++++++++++++++++++++-----
 5 files changed, 113 insertions(+), 32 deletions(-)

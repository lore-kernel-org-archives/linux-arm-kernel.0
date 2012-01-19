From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 Jan 2012 12:28:22 -0500 (EST)
Subject: [PATCH 03/11] Revert
 "RTC: sa1100: support sa1100, pxa and mmp soc families"
In-Reply-To: <20120119172136.GC10404@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
 <E1RntzR-0002pR-Br@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.02.1201191210350.19587@xanadu.home>
 <20120119171737.GB10404@n2100.arm.linux.org.uk>
 <20120119172136.GC10404@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1201191224160.19587@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jan 2012, Russell King - ARM Linux wrote:

> On Thu, Jan 19, 2012 at 05:17:37PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Jan 19, 2012 at 12:11:45PM -0500, Nicolas Pitre wrote:
> > > On Thu, 19 Jan 2012, Russell King - ARM Linux wrote:
> > > 
> > > > This reverts commit 7cea00657dd4daef66ad95e976d5d67ed94cb97e.
> > > > 
> > > > The sa1100 cleanups fatally broke the SA1100 RTC driver - the first
> > > > hint that something is wrong are these compiler warnings:
> > > > 
> > > > drivers/rtc/rtc-sa1100.c:42:1: warning: "RCNR" redefined
> > > > In file included from arch/arm/mach-sa1100/include/mach/hardware.h:73,
> > > >                  from drivers/rtc/rtc-sa1100.c:35:
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:877:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:43:1: warning: "RTAR" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:876:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:44:1: warning: "RTSR" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:879:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:45:1: warning: "RTTR" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:878:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:47:1: warning: "RTSR_HZE" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:891:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:48:1: warning: "RTSR_ALE" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:890:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:49:1: warning: "RTSR_HZ" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:889:1: warning: this is the location of the previous definition
> > > > drivers/rtc/rtc-sa1100.c:50:1: warning: "RTSR_AL" redefined
> > > > arch/arm/mach-sa1100/include/mach/SA-1100.h:888:1: warning: this is the location of the previous definition
> > > > 
> > > > and the second problem, which is far more severe, are the different
> > > > register layouts, resulting in the wrong registers being read on
> > > > SA11x0 platforms.  This patch adds:
> > > > 
> > > > but the SA11x0 registers are:
> > > > ---
> > > >  arch/arm/mach-pxa/devices.c    |   20 ---
> > > >  arch/arm/mach-sa1100/generic.c |   20 ---
> > > >  drivers/rtc/Kconfig            |    2 +-
> > > >  drivers/rtc/rtc-sa1100.c       |  256 ++++++++++++---------------------------
> > > >  4 files changed, 80 insertions(+), 218 deletions(-)
> > > [...]
> > > 
> > > Truncated log?
> > 
> > No, it appears that something decided to delete several lines from the
> > log file, particularly those between "This patch adds:" and the
> > "but the SA11x0 registers are".
> > 
> > I'll add them back, and hope git doesn't lose them again.
> 
> Ah.  No I can't add them.  They start with '#', and of course, git in
> its wonderful self decides that any line starting with such a character,
> even in the middle of a commit log, must be deleted.  Wonderful.
> 
> So, I'm afraid, that's all you get in the log, unless I can figure out
> a way around that.

Just add a space or a tab before the #.

Alternatively you can use git commit with -F to provide the log message 
from a specified file (using - for stdin works).


Nicolas

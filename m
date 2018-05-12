From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat, 12 May 2018 09:42:21 +0900
Subject: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
In-Reply-To: <20180508112503.GD16141@n2100.armlinux.org.uk>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
 <20180508112503.GD16141@n2100.armlinux.org.uk>
Message-ID: <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Could you pick this series to stable?

Thank you,

On Tue, 8 May 2018 12:25:03 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > This is the 3rd version of bugfix series for kprobes on arm.
> > This series fixes 4 different issues which I found.
> > 
> >  - Fix to use smp_processor_id() after disabling preemption.
> >  - Prohibit probing on optimized_callback() for avoiding
> >    recursive probe.
> >  - Prohibit kprobes on do_undefinstr() by same reason.
> >  - Prohibit kprobes on get_user() by same reason.
> > 
> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
> > which are not merged yet, and added "Cc: stable at vger.kernel.org",
> > since there are obvious bugs.
> 
> Please submit them to the patch system, thanks.
> 
> > 
> > Thanks,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >       arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
> >       arm: kprobes: Prohibit probing on optimized_callback
> >       arm: kprobes: Prohibit kprobes on do_undefinstr
> >       arm: kprobes: Prohibit kprobes on get_user functions
> > 
> > 
> >  arch/arm/include/asm/assembler.h  |   10 ++++++++++
> >  arch/arm/kernel/traps.c           |    5 ++++-
> >  arch/arm/lib/getuser.S            |   10 ++++++++++
> >  arch/arm/probes/kprobes/opt-arm.c |    4 +++-
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up


-- 
Masami Hiramatsu <mhiramat@kernel.org>

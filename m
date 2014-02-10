From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 10 Feb 2014 09:46:07 -0800
Subject: [PATCH v3 5/7] clocksource/cadence_ttc: Use only one counter
In-Reply-To: <alpine.DEB.2.02.1402042138480.24986@ionos.tec.linutronix.de>
References: <1391466877-28908-1-git-send-email-soren.brinkmann@xilinx.com>
 <1391466877-28908-6-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1402042138480.24986@ionos.tec.linutronix.de>
Message-ID: <6429e1bb-d4ad-4bf2-bd75-456324f45629@CO9EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Feb 04, 2014 at 09:41:53PM +0100, Thomas Gleixner wrote:
> On Mon, 3 Feb 2014, Soren Brinkmann wrote:
> 
> > Currently the driver uses two of the three counters the TTC provides to
> > implement a clocksource and a clockevent device. By using the TTC's
> > match feature we can implement both use cases using a single counter
> > only.
> 
> Are you entirely sure that this match feature is free of the infamous
> HPET match feature issues?
> 
> See arch/x86/kernel/hpet.c: hpet_next_event()
> 
> If yes, please add a comment. If no ....
Good catch. Looks like the comparator compares on == as well. So, I
assume it may show similar issues. I'll have to spend some more time
looking into this.

Thanks for applying the first two patches of the series.

	Thanks,
	S?ren

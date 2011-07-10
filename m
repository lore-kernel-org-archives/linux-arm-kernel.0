From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 15:19:35 +0100
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <20110602094622.GS3660@n2100.arm.linux.org.uk>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
	<20110602094622.GS3660@n2100.arm.linux.org.uk>
Message-ID: <20110710141935.GA21414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 10:46:22AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 02, 2011 at 11:34:31AM +0200, Mattias Wallin wrote:
> > The Multi Timer Unit (MTU) is currently used as clocksource and sched_clk
> > for the u8500 machine. The MTU block loose power during cpuidle sleep states
> > so an alternate clocksource is needed and these patches adds the db8500 PRCMU
> > timer.
> 
> Why don't we just find a way of fixing sched_clock so that the value
> doesn't reset over a suspend/resume cycle?  IOW, lets fix the problem
> for _everyone_ rather than only fixing it for one platform at a time.
> 
> Could you try this patch to check whether sched_clock() behaves better
> across a suspend/resume cycle please?

So do I merge this patch?

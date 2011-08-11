From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2011 09:25:15 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <20110810114907.GA2680@pulham.picochip.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<20110810114907.GA2680@pulham.picochip.com>
Message-ID: <20110811082515.GB4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 12:49:07PM +0100, Jamie Iles wrote:
> Tested on my 1176 platform and works nicely.  However, shouldn't the 
> read functions still be marked notrace so they don't appear in ftrace 
> output?
> 
> On my (out of tree) platform, omitting notrace and having all of the 
> ftrace bootup tests results in a hard lockup.  Annotating the read 
> function resolves this.

Why not also convert ftrace to use clocksources ?

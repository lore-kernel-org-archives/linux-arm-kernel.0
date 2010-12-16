From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 17:03:01 +0000
Subject: [PATCH] ARM: ensure all sched_clock() implementations are
	notrace marked
In-Reply-To: <AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
	<AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
	<20101216155750.GA28126@n2100.arm.linux.org.uk>
	<AANLkTikLoU-L4YF_FtG4Q8Qh+66zToun5p2LhgYyiyrv@mail.gmail.com>
Message-ID: <20101216170301.GU9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 09:52:56PM +0530, Rabin Vincent wrote:
> Yes, I now see U300 no longer needs the notrace addition.  It still
> could do with the #include <linux/sched.h> addition though, which was
> also being done as part of that patch.

Okay, added to u300, tegra, iop, and omap which weren't including
linux/sched.h explicitly.

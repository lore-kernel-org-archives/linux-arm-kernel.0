From: miles@gnu.org (Miles Bader)
Date: Mon, 24 Jan 2011 14:01:43 +0900
Subject: cannot fetch arm git tree
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 21 Jan 2011 14:50:26 +0000")
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
	<20110121145025.GS13235@n2100.arm.linux.org.uk>
Message-ID: <buok4huzyh4.fsf@dhlpc061.dev.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> I'm really not interested in working out how to bodge this into working
> along side the existing gitweb setup by adding lots of rewrite rules, so
> as gitweb got there first I think it has priority, that's what we have
> and we'll have to live without the smart http extensions.
...
> It's really not that big a deal if you follow the advice I've given.

Smart http is actually a very big deal -- the old git http protocol is
almost unusable in practice with big repos, at least over somewhat
latency-limited network connections.

If you don't intend to support people pulling over http, then maybe you
don't care.  But if you do care, it's very much worth a second look.

[My personal reason for caring is that I'm behind a corporate firewall
that's latency limited, although it seems to have pretty good bandwidth.
With some public repos, pulling via the old http protocol was a
multi-hour operation; the new http protocol is typically multiple orders
of magnitude faster in these cases.]

-Miles

-- 
Omochiroi!

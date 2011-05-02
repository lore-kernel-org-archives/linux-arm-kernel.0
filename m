From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 May 2011 23:22:11 +0100
Subject: [RFC PATCH] arm: move timer init to late_timer_init
In-Reply-To: <1304368940-19340-1-git-send-email-plagnioj@jcrosoft.com>
References: <1304368940-19340-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110502222211.GA28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 10:42:20PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> and add global early device init
> this will init earlytimer and will try to probe 1 or 2 timers for clockevents
> and clocksource

Why should this change the positioning of sched_clock initialization
too?

You know, to spend time sorting out the sched_clock crap that platform
people came up with, to get sched_clock working at the right point in
the init sequence so that everything is happy, and then to have all
that work undone one kernel version later... well, why did I even bother.

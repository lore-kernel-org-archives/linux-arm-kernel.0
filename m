From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 25 Jan 2013 12:08:23 -0500
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <20130125165934.GE2069@linaro.org>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-20-git-send-email-arnd@arndb.de>
 <20130125162608.GD2069@linaro.org>
 <1359132254.21576.230.camel@gandalf.local.home>
 <20130125165934.GE2069@linaro.org>
Message-ID: <1359133703.21576.233.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-25 at 16:59 +0000, Dave Martin wrote:

> Cool.  Are you aware of return_address being used elsewhere?  Currently
> I'm not aware of anything else which uses it, and grep is not finding
> any calls outside ftrace.h that I can see.

softirq.c has a trace_preempt_off() use of CALLER_ADDR1.

kernel/sched/core.c has CALLER_ADDR1, 2 an 3.

-- Steve

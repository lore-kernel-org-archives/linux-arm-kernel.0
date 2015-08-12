From: rabin@rab.in (Rabin Vincent)
Date: Wed, 12 Aug 2015 19:33:07 +0200
Subject: Problem with ftrace uprobes on ARM
In-Reply-To: <55CB1187.6030301@techfak.uni-bielefeld.de>
References: <55C8E417.7080607@techfak.uni-bielefeld.de>
 <20150810193116.GA2895@debian>
 <55CB1187.6030301@techfak.uni-bielefeld.de>
Message-ID: <20150812173307.GA19814@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 11:27:35AM +0200, Christian Ascheberg wrote:
> Is there any documentation regarding limitations of perf/ftrace support on
> ARM (compared to x86)?

There's Documentation/features/ which lists the status of architecture
support for various kernel options.  I don't know of any other
documentation.

> For example, I also noticed that 'perf help' lists 'trace' command, but
> running 'perf trace' says 'is not a perf-command'.

That doesn't have anything to do with something missing in ARM afaics.
It's probably because your perf wasn't built with libaudit.  Information
is printed about this when you build perf.  The fact that 'perf help'
lists unavailable commands is probably a bug.

 ~/dev/linux/tools/perf$ make
   BUILD:   Doing 'make -j8' parallel build
 config/Makefile:366: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev

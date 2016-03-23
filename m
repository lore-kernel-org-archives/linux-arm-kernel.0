From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 23 Mar 2016 08:53:59 +0100
Subject: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <8028886.DUEJzF47F1@vostro.rjw.lan>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com>
 <54039485.X1biSGXPBa@vostro.rjw.lan>
 <20160322224557.GG6356@twins.programming.kicks-ass.net>
 <8028886.DUEJzF47F1@vostro.rjw.lan>
Message-ID: <20160323075359.GH6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 01:50:00AM +0100, Rafael J. Wysocki wrote:

> > > Well, what about intel_idle_freeze()?  Or do we not care?
> > 
> > I argued against it; when you're suspended the NMI watchdog is stopped
> > too.
> 
> Is it also stopped for suspend-to-idle?  I'm not sure about that.
> 
> Where do I need to look to find out?

Hmm I have memories of writing a patch to that effect when we were
starting with that suspend-to-idle stuff, because people didn't like
being woken up all the time.

But now that I look I cannot find it either..

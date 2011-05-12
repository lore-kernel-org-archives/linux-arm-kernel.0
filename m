From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 12 May 2011 12:49:16 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110512092424.GO28888@outflux.net>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<20110512092424.GO28888@outflux.net>
Message-ID: <20110512104916.GJ9937@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <kees.cook@canonical.com> wrote:

> Hi,
> 
> On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> > 1) We already have a specific ABI for this: you can set filters for events via 
> >    an event fd.
> > 
> >    Why not extend that mechanism instead and improve *both* your sandboxing
> >    bits and the events code? This new seccomp code has a lot more
> >    to do with trace event filters than the minimal old seccomp code ...
> 
> Would this require privileges to get the event fd to start with? [...]

No special privileges with the default perf_events_paranoid value.

> [...] If so, I would prefer to avoid that, since using prctl() as shown in 
> the patch set won't require any privs.

and we could also explicitly allow syscall events without any privileges, 
regardless of the setting of 'perf_events_paranoid' config value.

Obviously a sandboxing host process wants to run with as low privileges as it 
can.

Thanks,

	Ingo

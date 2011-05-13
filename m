From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 13 May 2011 14:49:02 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305290370.2466.14.camel@twins>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
Message-ID: <20110513124902.GC3924@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > Why should we have two callbacks next to each other:
> > 
> > 	event_vfs_getname(result);
> > 	result = check_event_vfs_getname(result);
> > 
> > if one could do it all?
> 
> Did you actually read the bit where I said that check_event_* (although
> I still think that name sucks) could imply a matching event_*?

No, did not notice that - and yes that solves this particular problem.

So given that by your own admission it makes sense to share the facilities at 
the low level, i also argue that it makes sense to share as high up as 
possible.

Are you perhaps arguing for a ->observe flag that would make 100% sure that the 
default behavior for events is observe-only? That would make sense indeed.

Otherwise both cases really want to use all the same facilities for event 
discovery, setup, control and potential extraction of events.

Thanks,

	Ingo

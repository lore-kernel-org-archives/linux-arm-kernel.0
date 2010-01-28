From: t.fujak@samsung.com (Tomasz Fujak)
Date: Thu, 28 Jan 2010 12:57:47 +0100
Subject: [PATCH/RFC v2 0/3] Human readable platform-specific performance
	event support
In-Reply-To: <1264675934.4283.2088.camel@laptop>
References: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
	<1264675934.4283.2088.camel@laptop>
Message-ID: <000101caa011$1ba9ee10$52fdca30$%fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz at infradead.org]
> Sent: Thursday, January 28, 2010 11:52 AM
> To: Tomasz Fujak
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> acme at redhat.com; jamie.iles at picochip.com; will.deacon at arm.com;
> jpihet at mvista.com; mingo at elte.hu; p.osciak at samsung.com;
> m.szyprowski at samsung.com; kyungmin.park at samsung.com;
> m.nazarewicz at samsung.com
> Subject: Re: [PATCH/RFC v2 0/3] Human readable platform-specific
> performance event support
> 
> On Thu, 2010-01-28 at 10:34 +0100, Tomasz Fujak wrote:
> > Human readable description support for performance events v2. With
> perf support included.
> > Changes from v1:
> >  - applied on top of latest perf_event/ARM (5899/1 - 5903/1)
> >  - moved to debugfs, now based on seq_file
> >  - reads one line at a time, memory overallocation fixed [perf]
> 
> You can keep sending these patches, but I'll keep ignoring them
> eventually adding you to the /dev/null redirect.

Apparently I did not comprehend your attitude towards the events' description being exported from the kernel.
There's been a lengthy discussion which ended in a conclusion that the platform detection is a complicated task.

The solution finally accepted covers just a subset of platforms. I guess the detection scheme may be updated and possibly changed as new cores/implementers come into sight.
That I think provides additional reasoning to keep the event list where it's defined (in the kernel).
The rest of the suggestions (perf implementation, debugfs instead of sysfs) I've included into the posted patches.

Therefore I cannot really understand why you're threatening to ignore my further efforts; especially since the arguments me and my teammate Michal brought I find reasonable.

So finally, if the proposed patches are too intrusive, can you imagine other mechanism in the kernel that would let the userspace unambiguously retrieve a list of supported events?
Maybe an entry in the sysfs that indicates supported event list version (relevant to the implementer, cupid and other black magic that is involved into the platform detection)?

Right now what can be done is to try follow the kernel implementation of the detection scheme in the applications, which I can't say I'm a fan of.

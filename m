From: t.fujak@samsung.com (Tomasz Fujak)
Date: Thu, 28 Jan 2010 13:40:25 +0100
Subject: [PATCH/RFC v2 0/3] Human readable platform-specific performance
	event support
In-Reply-To: <1264680815.4283.2100.camel@laptop>
References: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
	<1264675934.4283.2088.camel@laptop>
	<000101caa011$1ba9ee10$52fdca30$%fujak@samsung.com>
	<1264680815.4283.2100.camel@laptop>
Message-ID: <000201caa017$104aa5e0$30dff1a0$%fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, I missed your statement from yesterday, that's why I posted the same
idea :s

Otherwise if the perf is meant to be closely tied to the kernel, maybe we
could use a (semi-)automated process to transform the event definitions 
(enums in a .c file) to something perf could use. Basically a replacement
for sysfs/debugfs entry in a separately distributed file.

But that does not look so straightforward to implement to me, maybe I'll
come up with something next week.

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Peter Zijlstra
> Sent: Thursday, January 28, 2010 1:14 PM
> To: Tomasz Fujak
> Cc: jpihet at mvista.com; Michal Nazarewicz; Pawel Osciak;
> jamie.iles at picochip.com; will.deacon at arm.com; linux-
> kernel at vger.kernel.org; acme at redhat.com; kyungmin.park at samsung.com;
> mingo at elte.hu; linux-arm-kernel at lists.infradead.org; Marek Szyprowski
> Subject: RE: [PATCH/RFC v2 0/3] Human readable platform-specific
> performance event support
> 
> On Thu, 2010-01-28 at 12:57 +0100, Tomasz Fujak wrote:
> 
> please educate your MUA to wrap lines at ~80.
> 
> > Apparently I did not comprehend your attitude towards the events'
> > description being exported from the kernel.
> > There's been a lengthy discussion which ended in a conclusion that
> the
> > platform detection is a complicated task.
> 
> If its really that complicated export a pmu identifier someplace.
> 
> The fact is, the kernel simply doesn't use this list, we have perf in
> kernel so that resource scheduling and isolation can be done, for that
> we need to know how to program the hardware and we need to know about
> scheduling constraints, we do not need exhaustive lists of possible
> events, let alone descriptive text for them, in the kernel.
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

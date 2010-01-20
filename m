From: jamie.iles@picochip.com (Jamie Iles)
Date: Wed, 20 Jan 2010 13:31:45 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event description
	in sysfs
In-Reply-To: <op.u6tslipz7p4s8u@pikus>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
Message-ID: <20100120133145.GE4089@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 10:57:08AM +0100, Micha? Nazarewicz wrote:
>>> The following patches provide a sysfs entry with hardware event human
>>> readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
>>> (event_value, minval, maxval, name, description) and means to populate
>>> the file.
>>>
>>> The intended use is twofold: for users to read the list directly and
>>> for tools (like perf).
>
> On Wed, 20 Jan 2010 10:16:39 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
>> Why do this in kernel space? Listing available events seems like
>> something we can do from userspace just fine.
>
> IMO kernel knows better what hardware it's running on and user space
> should not care and if this list were to be kept in user space it
> would have to detect the processor it's running on and act accordingly.
>
> Also, keeping the list in user space could lead to different software
> maintaining separate lists which would get out of sync.  I think it's
> easier to update a single list in kernel then wait till all the
> software packages update theirs.
>
> This also means that different tools would use different names and
> descriptions for the events which would only increase confusion.
Personally I think this is a good idea. At the moment 'perf list' gives lots
of events that the system isn't capable of counting. Admittedly it's fairly
easy to see if they are supported but it would be nice if the list reflected
the countable events. perf already does this for the tracing events so it
would be nice if it did the same for the hardware events. I guess the same
hierarchy would be nice too.

The main problem I can envisage is that different CPUs could use slightly
different names for the same event.

Jamie

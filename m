From: t.fujak@samsung.com (Tomasz Fujak)
Date: Wed, 20 Jan 2010 11:21:51 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event description in
	sysfs
In-Reply-To: <20100120095757.GA20302@n2100.arm.linux.org.uk>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<20100120095757.GA20302@n2100.arm.linux.org.uk>
Message-ID: <023f01ca99ba$61ce7e90$256b7bb0$%fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM
> Linux
> Sent: Wednesday, January 20, 2010 10:58 AM
> To: Tomasz Fujak
> Cc: jpihet at mvista.com; peterz at infradead.org; p.osciak at samsung.com;
> jamie.iles at picochip.com; will.deacon at arm.com; linux-
> kernel at vger.kernel.org; kyungmin.park at samsung.com; mingo at elte.hu;
> linux-arm-kernel at lists.infradead.org; m.szyprowski at samsung.com
> Subject: Re: [PATCH/RFC v1 0/2] Human readable performance event
> description in sysfs
> 
> On Wed, Jan 20, 2010 at 10:11:44AM +0100, Tomasz Fujak wrote:
> > The following patches provide a sysfs entry with hardware event human
> > readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
> > (event_value, minval, maxval, name, description)
> 
> I think your patch is in violation of this from
> Documentation/filesystems/sysfs.txt:
> 
> Attributes
> ~~~~~~~~~
> ...
> Attributes should be ASCII text files, preferably with only one value
> per file. It is noted that it may not be efficient to contain only one
> value per file, so it is socially acceptable to express an array of
> values of the same type.
> 
> Mixing types, expressing multiple lines of data, and doing fancy
> formatting of data is heavily frowned upon. Doing these things may get
> you publically humiliated and your code rewritten without notice.

1. There are numerous exceptions:
$ find /sys -exec grep -HC ^ {} \; 2>/dev/null | grep ":[3-9]$" | grep -c
yielded 43 on my machine.
Some of them list multiple lines with fancy formatting each (i.e.:
/sys/class/Bluetooth/l2cap or devices/pci*/resource)

2. There are sysfs entries regarding the performance counters already:
'overcommit' and 'reserve_percpu'
They are simple, I admit, but I find it useful to have all relevant thing in
one place.

If the above does not convince you, I could move the file to the debugfs.

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

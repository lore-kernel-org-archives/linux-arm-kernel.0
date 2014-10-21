From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Oct 2014 12:05:42 +0200
Subject: [PATCH v3 5/6] Documentation: dt-bindings: Add binding info for
 X-Gene QMTM UIO driver
In-Reply-To: <20141021091412.GB15293@leverpostej>
References: <1413871011-4101-1-git-send-email-ankit.jindal@linaro.org>
 <1413871011-4101-6-git-send-email-ankit.jindal@linaro.org>
 <20141021091412.GB15293@leverpostej>
Message-ID: <3725049.9xPbukhCva@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 10:14:12 Mark Rutland wrote:
> 
> > +The Applied Micro X-Gene SOC has on-chip QMTM (Queue manager
> > +and Traffic manager). It is a device for managing hardware queues.
> > +It also implements QoS among hardware queues hence term "traffic"
> > +manager is present in its name. QMTM UIO nodes are defined for user
> > +space access to this device using UIO framework.
> 
> The binding should describe the hardware, not the software. Please drop
> mention of UIO, userspace, etc.

I have a bad feeling about the entire idea of doing the UIO driver first,
there are too many unknowns here and we should not break the binding
when the proper driver gets added.

The X-Gene is meant for server workloads, so the UIO approach is not
a good longterm solution anyway. My impression is that it would be
better to first get the kernel driver for this hardware merged and
the binding fixed, and then a UIO stub could get added to that driver,
taking over the hardware by user space. This would also solve the
arbitration between the two driver implementations. It's also possible
that by that time, we will have a functional VFIO framework for
platform devices.

	Arnd

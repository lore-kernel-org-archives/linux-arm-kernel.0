From: monstr@monstr.eu (Michal Simek)
Date: Wed, 20 Jun 2012 08:48:07 +0200
Subject: [RFC PATCH 1/8] ARM: gic: Support forcing cpumask for possible
 cpus in the system
In-Reply-To: <4FDF1400.6090402@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-2-git-send-email-monstr@monstr.eu>
 <20120618113339.GC12029@n2100.arm.linux.org.uk>
 <4FDF1400.6090402@monstr.eu>
Message-ID: <CAHTX3d+oprSkMLABVGCyv45jU7t57DYV3RvrvPN8DPKdVS6mzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/18 Michal Simek <monstr@monstr.eu>

> On 06/18/2012 01:33 PM, Russell King - ARM Linux wrote:
>
>> On Mon, Jun 18, 2012 at 01:30:04PM +0200, Michal Simek wrote:
>>
>>> gic_set_affinity doesn't support force option. Force option
>>> should work with all possible cpus in the system not only with
>>> online cpus.
>>>
>>
>> Neither does x86.  Why do you want this?  Offline CPUs are unable to
>> receive the interrupt in any case (and must not receive interrupts in
>> the bringup path until they are online.)
>>
>
> The whole reason for all these changes in AMP on dual core Cortex A9 where
> on one cpu runs Linux and on the second RTOS/standlone.
>
> It means that the second cpu is from Linux point of view offline all the
> time.
> But GIC has to be (and can be) setup to forward IRQ directly to the second
> cpu.
> GIC should be controlled by Linux.
>
>
Russel: Any other reaction?
Can you see a way how to get this feature to the mainline Linux kernel?
Some patches needs to be refactored a little bit but the point is if you
are willing to
support this type of configuration.

Not sure if Ohad has any information that someone else would like to use it
remoteproc(AMP) among ARM cores.

Thanks,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120620/5d1c190a/attachment-0001.html>

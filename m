From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 2 Apr 2011 22:47:57 -0600
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
Message-ID: <BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2011 at 3:10 AM, Colin Cross <ccross@google.com> wrote:
> On Sat, Apr 2, 2011 at 1:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
>>> On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com> wrote:
>>> > I?m getting ready to submit a patch to add SMP to Xilinx code. I notice that
>>> > smp_cross_call for all GIC based platforms is duplicated across each
>>> > platform in smp.h.
>>> >
>>> >
>>> >
>>> > I thought I?d try to jump in to help with some cleanup, although I realize
>>> > it?s minimal, I have to start somewhere.
>>> >
>>> >
>>> >
>>> > What about moving the smp_cross_call for GIC based designs into gic.h?
>>>
>>> Go for it. ?It's an obvious cleanup.
>>
>> That assumes that all SMP implementations will always have a GIC. ?It
>> looks to me like this is conditional on shmobile, and so I don't think
>> its that trivial - maybe Paul or Magnus can first indicate why this is.
>
> OMAP4 may also require a custom smp_cross_call implementation if CPU
> idle is going to be supported in SMP - in CPU off idle modes, a GIC
> SGI will not wake the CPU, and a write directly to the CPU's power
> management controller or an external interrupt source would be
> required.

What John proposes appears to be a pretty sane default though.  It
would make sense to move it to common code, and require explicit
action on the part of the subarch to compile it out for a different
behaviour.  Requiring each subarch to define it explicitly doesn't
seem optimal.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

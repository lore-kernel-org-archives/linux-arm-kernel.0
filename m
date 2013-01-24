From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 24 Jan 2013 13:42:51 +0100
Subject: [PATCH] ARM: dts: specify all the per-cpu interrupts of arch
 timer for exynos5440
In-Reply-To: <50FFC1B0.8000601@ti.com>
References: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
 <20130122101554.GA18876@e106331-lin.cambridge.arm.com>
 <063f01cdf8ec$926cda30$b7468e90$@samsung.com>
 <20130123103614.GD32237@e106331-lin.cambridge.arm.com>
 <50FFC1B0.8000601@ti.com>
Message-ID: <51012C4B.5080300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On 01/23/2013 11:55 AM, Santosh Shilimkar wrote:
> Looping Marc, Benoit
> 
> On Wednesday 23 January 2013 04:06 PM, Mark Rutland wrote:
>> On Tue, Jan 22, 2013 at 10:05:18PM +0000, Kukjin Kim wrote:
>>> Mark Rutland wrote:
>>>>
>>> + devicetree-discuss, Grant Likely, Rob Herring and Tony Lindgren
>>>
>>>> On Tue, Jan 22, 2013 at 01:41:27AM +0000, Kukjin Kim wrote:
>>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>>
>>>>> Need to be changed requirements in the 'cpus' node for exynos5440
>>>>> to specify all the per-cpu interrupts of arch timer.
>>>>
>>>> The node(s) for the arch timer should not be in the cpus/cpu at N nodes.
>>>> Instead, there should be one node (in the root of the tree).
>>>>
>>> Well, I don't think so. As per my understanding, the local timers are
>>> attached to every ARM cores (cpus) and it generates certain interrupt
>>> to the
>>> GIC. So the correct representation for this in device tree is to
>>> include the
>>> interrupts in the cpu nodes in dts file. Your comments  refer to a
>>> limitation in the Linux kernel implementation of the arch_timer and it
>>> should not result in representing the hardware details incorrectly in
>>> the
>>> dts file.
>>
>> I disagree. The "correct representation" is whatever the devicetree
>> binding
>> documentation describes. It does not describe placing timer nodes in
>> the cpu
>> nodes.
>>
> This seems to be exact same topic what is getting discussed here [1]
> Technically DT is suppose to represent how the hardware is rather than
> how the bindings are done.
> 
> But as Marc pointed out, the approach taken currently is to not
> duplicate the banked information. The thread [1] isn't concluded
> yet but looks like we might want to avoid duplicating the information
> considering, more of such duplication needs to follow. e.g gic i/f
> 
> Am still waiting on what Benoit has to say ?

I agree with you :-)

I'm not sure the binding was properly done to reflect the HW accurately.

A local timer for my point of view should be located in the cpu node
like a L1 cache. Or at least referenced in each cpu by a phandle.

What was the rational to put it in the root?

Regards,
Benoit

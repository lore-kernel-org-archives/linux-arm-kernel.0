From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 1 Aug 2014 11:19:18 -0500
Subject: [PATCH 4/4 V3] irqchip: gicv2m: Add support for multiple MSI
 for ARM64 GICv2m
In-Reply-To: <53DBA986.90705@arm.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1404947104-21345-5-git-send-email-suravee.suthikulpanit@amd.com>
 <87vbqej2rj.fsf@approximate.cambridge.arm.com> <53DBA603.9030509@amd.com>
 <53DBA986.90705@arm.com>
Message-ID: <53DBBE06.5040307@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2014 9:51 AM, Marc Zyngier wrote:
> Hi Suravee,
>
> On 01/08/14 15:36, Suravee Suthikulanit wrote:
>> On 7/30/2014 10:16 AM, Marc Zyngier wrote:
>>> Why do we need this complexity at all? Is there any case where we'd want
>>> to limit ourselves to a single vector for MSI?
>>
>> I think the ARM64 GICv2m should not be the limitation for the devices
>> multiple MSI if there is no real hardware/design limitation.
>>
>>> arm64 is a new enough architecture so that we can expect all interrupt controllers to cope
>>> with that.
>>
>> I am not sure if I understand this comment.
>>
>> We are not forcing all interrupt controllers for ARM64 to handle
>> multi-MSI.  They have the option to support if multi-MSI if they want
>> to. I just think that we should not put the architectural limit here.
>
> Let me be clearer: I think we should put the burden of *not* handling
> multi-MSI on interrupt controllers. Here, you're making the
> architectural default to be "I don't support multi-MSI", hence having to
> override global vectors and such for well behaved MSI controllers like
> GICv2m and GICv3 ITS.
>
> Let's only support multi-MSI for the time being. If someone comes up
> with a silly old MSI controller that can't deal with it, we'll address
> the issue at that problem.
>
> Thanks,
>
> 	M.
>

Ok, I'm fine with that. Thanks for clarification.

Suravee

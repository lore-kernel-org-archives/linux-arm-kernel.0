From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Sep 2013 11:20:19 +0200
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130905090841.GA9696@mudshark.cambridge.arm.com>
References: <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost> <20130823114805.GF10971@arm.com>
 <20130830090807.GB25628@mudshark.cambridge.arm.com>
 <20130830091534.GA62188@MacBook-Pro.local>
 <20130830092032.GD25628@mudshark.cambridge.arm.com>
 <20130830100342.GD62188@MacBook-Pro.local>
 <522847FC.1080005@free-electrons.com>
 <20130905090841.GA9696@mudshark.cambridge.arm.com>
Message-ID: <52284CD3.7020804@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2013 11:08, Will Deacon wrote:
> On Thu, Sep 05, 2013 at 09:59:40AM +0100, Gregory CLEMENT wrote:
>> Hi all,
> 
> Hi Gregory,
> 
>> On 30/08/2013 12:03, Catalin Marinas wrote:
>>> On Fri, Aug 30, 2013 at 10:20:33AM +0100, Will Deacon wrote:
>>>> Perhaps we should just bit the bullet and define relaxed accessors for all
>>>> architectures? It's not difficult to default them to the non-relaxed
>>>> variants if the architecture doesn't provide an optimised implementation.
>>>
>>> Yes, an asm-generic default relaxed would be good (that's what I
>>> suggested earlier in this thread and it was discussed in the past). But
>>> no-one volunteered ;).
>>>
>>
>> I would like to make the things move on about this subject. Should it
>> be possible to merge this version of the patch set? Currently the
>> only users of this new API are drivers for ARM SoCs.
> 
> In the short term then, I'd keep this restricted to ARM. Without relaxed
> accessors available across all architectures, I don't think we can make this
> usefully generic (a readX/writeX version would be horribly slow on ARM).

OK

> 
>> In the meantime, I am willing to introduce an asm-generic default
>> relaxed variant of read and write, but as Catalin had already pointed
>> in the past
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/117626
>> it may take time to get an agreement from all the other architectures.
> 
> I actually wrote those patches yesterday but, in doing so, I realised that

Great!

> the kernel doesn't have well-defined semantics for relaxed I/O accessors
> (i.e. different architectures use them to mean different things). That makes
> portability is an issue, even if the functions are defined everywhere.

It confirms that Catalin pointed in this old thread.

> 
>> That's why I propose that this patch set do not depend on the
>> introduction of a asm-generic default relaxed variant of read and
>> write. Later when it will be accepted then this new API will be moved
>> in the asm-generic part.
> 
> Indeed, we can't make this generic until we've resolved the issues I mention
> above. I'll start a new thread around that once I've put my thoughts
> together, but that needn't block this patch imo.

I will definitely have a look on this thread!

> 
> That said, I'd still suggest resending a final version of this patch, since
> there were some minor issues with this iteration.

Yes sure, I suspect that Ezequiel already fixed  all the issues and is ready
to send a new iteration.

> 
> Cheers,
> 
> Will
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

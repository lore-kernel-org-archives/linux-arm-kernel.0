From: liran.alon@oracle.com (Liran Alon)
Date: Sun, 14 Oct 2018 12:20:00 +0300
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
In-Reply-To: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
Message-ID: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Sun, 14 Oct 2018, Liran Alon wrote:
>>> On 13 Oct 2018, at 17:53, lantianyu1986 at gmail.com wrote:
>>> 
>>> +
>>> +static inline bool kvm_available_flush_tlb_with_range(void)
>>> +{
>>> +	return kvm_x86_ops->tlb_remote_flush_with_range;
>>> +}
>> 
>> Seems that kvm_available_flush_tlb_with_range() is not used in this patch?
> 
> What's wrong with that? 
> 
> It provides the implementation and later patches make use of it. It's a
> sensible way to split patches into small, self contained entities.
> 
> Thanks,
> 
> 	tglx
> 	

I guess it?s a matter of taste, but I prefer to not add dead-code for patches
in order for each commit to compile nicely without warnings of declared and unused functions.
I would prefer to just add this utility function on the patch that actually use it.

-Liran

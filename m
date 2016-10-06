From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 06 Oct 2016 10:43:14 +0100
Subject: [PATCH 5/7] arm64/kvm: hyp: tlb: use __tlbi() helper
In-Reply-To: <07921948-8692-67c1-8ae9-a68f0cc387c8@suse.com> (Matthias
 Brugger's message of "Wed, 5 Oct 2016 18:41:02 +0200")
References: <1473761769-30572-1-git-send-email-punit.agrawal@arm.com>
 <1473761769-30572-6-git-send-email-punit.agrawal@arm.com>
 <07921948-8692-67c1-8ae9-a68f0cc387c8@suse.com>
Message-ID: <87eg3tyfrh.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Brugger <mbrugger@suse.com> writes:

> On 13/09/16 12:16, Punit Agrawal wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> Now that we have a __tlbi() helper, make use of this in the arm64 KVM hyp
>> code to get rid of asm() boilerplate. At the same time, we simplify
>> __tlb_flush_vm_context by using __flush_icache_all(), as this has the
>> appropriate instruction cache maintenance and barrier.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> [ rename tlbi -> __tlbi, convert additional sites, update commit log ]
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>> ---
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Thanks for reviewing the patch. I'll re-spin a new version with the tag
after the merge window.

Punit


[...]

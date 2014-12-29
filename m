From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Dec 2014 06:04:45 +0000
Subject: [PATCH] arm64: KVM: Fix TLB invalidation by IPA/VMID
In-Reply-To: <20141228182047.GA29460@cbox> (Christoffer Dall's message of
 "Sun, 28 Dec 2014 18:20:47 +0000")
References: <1419009527-21565-1-git-send-email-marc.zyngier@arm.com>
 <20141228182047.GA29460@cbox>
Message-ID: <86h9wfm1oi.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 28 2014 at 06:20:47 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Dec 19, 2014 at 05:18:47PM +0000, Marc Zyngier wrote:
>> It took about two years for someone to notice that the IPA passed
>> to TLBI IPAS2E1IS must be shifted by 12 bits. Clearly our reviewing
>> is not as good as it should be...
>> 
>> Paper bag time for me.
>> 
>> Reported-by: Mario Smarduch <m.smarduch@samsung.com>
>> Tested-by: Mario Smarduch <m.smarduch@samsung.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Thanks, applied to queue.

Thanks for picking this up. This should also be CC-ed to -stable, as all
versions of the kernel since 3.11 are affected.

	M.
-- 
Jazz is not dead. It just smells funny.

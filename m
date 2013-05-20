From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 May 2013 16:43:06 +0100
Subject: [PATCH v4 02/32] arm64: KVM: HYP mode idmap support
In-Reply-To: <20130520153142.GA3639@MacBook-Pro.local>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-3-git-send-email-marc.zyngier@arm.com>
 <20130520153142.GA3639@MacBook-Pro.local>
Message-ID: <519A448A.4000506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/13 16:31, Catalin Marinas wrote:
> On Tue, May 14, 2013 at 03:13:30PM +0100, Marc Zyngier wrote:
>> Add the necessary infrastructure for identity-mapped HYP page
>> tables. Idmap-ed code must be in the ".hyp.idmap.text" linker
>> section.
>>
>> The rest of the HYP ends up in ".hyp.text".
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ...
>> +/*
>> + * The HYP init code can't be more than a page long.
>> + */
>> +ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) >= __hyp_idmap_text_end),
>> +       "HYP init code too big")
> 
> Is __hyp_idmap_text_end inclusive or exclusive? I think the latter and
> you can use greater than (without equal).

Indeed. I'll update the check.

> Otherwise:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Apr 2013 15:07:12 +0100
Subject: [PATCH v3 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <20130419133658.GQ14496@n2100.arm.linux.org.uk>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
 <1365779932-20322-7-git-send-email-marc.zyngier@arm.com>
 <20130419133658.GQ14496@n2100.arm.linux.org.uk>
Message-ID: <51714F90.6060705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/13 14:36, Russell King - ARM Linux wrote:
> On Fri, Apr 12, 2013 at 04:18:51PM +0100, Marc Zyngier wrote:
>> @@ -247,7 +265,11 @@ static int __create_hyp_mappings(pgd_t *pgdp,
>>  				goto out;
>>  			}
>>  			pud_populate(NULL, pud, pmd);
>> +<<<<<<< HEAD
>>  			get_page(virt_to_page(pud));
>> +=======
>> +			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
>> +>>>>>>> 180de35... ARM: KVM: switch to a dual-step HYP init code
> 
> I don't think you want this in your patch... and as no one else spotted
> this, has anyone looked at this patch set yet?

I posted a revised version within minutes of posting this crap.

As far as I know, Christoffer has reviewed it.

	M.
-- 
Jazz is not dead. It just smells funny...

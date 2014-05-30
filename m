From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 30 May 2014 09:48:15 -0700
Subject: [PATCH v5 2/4] live migration support for initial write protect of
 VM
In-Reply-To: <20140515185312.GA6159@lvm>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
 <1399509616-4632-3-git-send-email-m.smarduch@samsung.com>
 <20140515185312.GA6159@lvm>
Message-ID: <5388B64F.3080100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>  
>> +static inline void kvm_set_s2pte_readonly(pte_t *pte)
>> +{
>> +	pte_val(*pte) &= ~(L_PTE_S2_RDONLY ^ L_PTE_S2_RDWR);
> 
> This relies on the pte already having been set as RDONLY or RDWR, if you
> are creating a new pte and calling this function it could be easy to
> miss that distinction, I would prefer:
> 
> pte_val(*pte) &= L_PTE_S2_RDWR;
> pte_val(*pte) |= L_PTE_S2_RDONLY;
> 

Confused on this comment, this appears to just add the read-only
permission. But will leave other permission bits intact, and
clears out the rest of the pte?

- Mario

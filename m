From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 May 2013 17:17:31 +0100
Subject: [PATCH v4 07/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <20130520155739.GF3639@MacBook-Pro.local>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-8-git-send-email-marc.zyngier@arm.com>
 <20130520155739.GF3639@MacBook-Pro.local>
Message-ID: <519A4C9B.8070307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/13 16:57, Catalin Marinas wrote:
> On Tue, May 14, 2013 at 03:13:35PM +0100, Marc Zyngier wrote:
>> +static inline bool kvm_is_write_fault(unsigned long esr)
>> +{
>> +	unsigned long esr_ec = esr >> ESR_EL2_EC_SHIFT;
> 
> Not that it would make much difference but for consistency - we use esr
> as an 'unsigned int' in the arm64 code (only 32-bit needed).

Indeed. Changing it would require a 32bit patch though, as I'd like to
keep the two code bases in line.

If you don't mind, I'll queue a patch changing this to "unsigned int" on
both architectures once this is merged.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

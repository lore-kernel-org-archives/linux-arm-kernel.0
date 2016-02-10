From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 16:07:07 +0000
Subject: [PATCH v2 20/28] ARM: KVM: Change kvm_call_hyp return type to
 unsigned long
In-Reply-To: <20160209182828.GB5171@cbox>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-21-git-send-email-marc.zyngier@arm.com>
 <20160209182828.GB5171@cbox>
Message-ID: <56BB602B.4060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 18:28, Christoffer Dall wrote:
> On Thu, Feb 04, 2016 at 11:00:37AM +0000, Marc Zyngier wrote:
>> Having u64 as the kvm_call_hyp return type is problematic, as
>> it forces all kind of tricks for the return values from HYP
>> to be promoted to 64bit (LE has the LSB in r0, and BE has them
>> in r1).
>>
>> Since the only user of the return value is perfectly happy with
>> a 32bit value, let's make kvm_call_hyp return an unsigned long,
>> which is 32bit on ARM.
> 
> I wonder why I ever did this as a u64...

Probably to cater for the largest possible return value, before we
started looking at BE... ;-)

> should the arm64 counterpart be modified to an unsigned long as well?

That'd be a sensible change.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

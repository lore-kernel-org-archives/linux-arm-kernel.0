From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 9 Dec 2015 16:47:52 +0800
Subject: [PATCH v6 14/21] KVM: ARM64: Add reset and access handlers for
 PMOVSSET and PMOVSCLR register
In-Reply-To: <56670C5D.3020407@arm.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
 <1449578860-15808-15-git-send-email-zhaoshenglong@huawei.com>
 <56670C5D.3020407@arm.com>
Message-ID: <5667EAB8.9030502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/9 0:59, Marc Zyngier wrote:
>> > +	}
>> > +
>> > +	/* If all overflow bits are cleared, kick the vcpu to clear interrupt
>> > +	 * pending status.
>> > +	 */
>> > +	if (val == 0)
>> > +		kvm_vcpu_kick(vcpu);
> Do we really need to do so? This will be dropped on the next entry
> anyway, so i don't see the need to kick the vcpu again. Or am I missing
> something?
> 
I thought maybe it could not set the interrupt low immediately when all
the overflow bits are cleared for some reason, so add a kick to force it
to sync the interrupt. But as you said, I'll remove this.

Thanks,
-- 
Shannon

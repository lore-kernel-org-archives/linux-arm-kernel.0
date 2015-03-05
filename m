From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 05 Mar 2015 11:33:07 +0000
Subject: [PATCH v9 5/5] KVM: arm/arm64: add irqfd support
In-Reply-To: <54F83DAE.2060607@redhat.com>
References: <1425464076-20558-1-git-send-email-eric.auger@linaro.org>
 <1425464076-20558-6-git-send-email-eric.auger@linaro.org>
 <54F8359A.4020405@arm.com> <54F83DAE.2060607@redhat.com>
Message-ID: <54F83EF3.4070903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/15 11:27, Paolo Bonzini wrote:
> 
> 
> On 05/03/2015 11:53, Marc Zyngier wrote:
>>> +#ifdef CONFIG_HAVE_KVM_IRQFD
>>> +	case KVM_CAP_IRQFD:
>>> +		r = vgic_present;
>>> +		break;
>>> +#endif
>>
>> Nitpick: we have "select HAVE_KVM_IRQFD", so we can lose the #ifdef-ery.
> 
> Alternatively, I've just posted a patch to move the KVM_CAP_IRQFD case
> to common code.
> 
> vgic_present probably should be replaced by
> IS_ENABLED(CONFIG_KVM_ARM_VGIC).  I've sent a patch for this.

Right. We can probably take this at the same time as Eric's series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

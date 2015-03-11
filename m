From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Mar 2015 17:54:52 +0100
Subject: [PATCH v9 5/5] KVM: arm/arm64: add irqfd support
In-Reply-To: <20150311142418.GB14799@cbox>
References: <1425464076-20558-1-git-send-email-eric.auger@linaro.org>
 <1425464076-20558-6-git-send-email-eric.auger@linaro.org>
 <54F8359A.4020405@arm.com> <54F83DAE.2060607@redhat.com>
 <20150311142418.GB14799@cbox>
Message-ID: <5500735C.4070903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 03:24 PM, Christoffer Dall wrote:
> On Thu, Mar 05, 2015 at 12:27:42PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 05/03/2015 11:53, Marc Zyngier wrote:
>>>> +#ifdef CONFIG_HAVE_KVM_IRQFD
>>>> +	case KVM_CAP_IRQFD:
>>>> +		r = vgic_present;
>>>> +		break;
>>>> +#endif
>>>
>>> Nitpick: we have "select HAVE_KVM_IRQFD", so we can lose the #ifdef-ery.
>>
>> Alternatively, I've just posted a patch to move the KVM_CAP_IRQFD case
>> to common code.
>>
>> vgic_present probably should be replaced by
>> IS_ENABLED(CONFIG_KVM_ARM_VGIC).  I've sent a patch for this.
>>
> I have applied all of this together with my kill-the-vgic-config-option
> patch here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git queue
> 
> Take a look please.

Hi Christoffer,

This looks good to me. Thanks for the integration.

- Eric
> 
> Thanks,
> -Christoffer
> 

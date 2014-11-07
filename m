From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 07 Nov 2014 10:26:41 +0100
Subject: [PATCH v13 2/7] KVM: Add generic support for dirty page logging
In-Reply-To: <20141107100721.44c34175.cornelia.huck@de.ibm.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>	<1415320848-13813-3-git-send-email-m.smarduch@samsung.com>
 <20141107100721.44c34175.cornelia.huck@de.ibm.com>
Message-ID: <545C9051.5060401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/2014 10:07, Cornelia Huck wrote:
>> > +#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_MIPS) || \
>> > +    defined(CONFIG_IA64) || defined(CONFIG_X86) || defined(CONFIG_ARM) || \
>> > +    defined(CONFIG_ARM64)
> Does this deserve a config symbol that can be selected by architectures
> actually using kvm_get_dirty_log_protect()? I.e.,
> 
> #ifndef CONFIG_KVM_ARCH_DIRTY_LOG_PROTECT
> 
> or so?

Yes, either that or invert the #if to negative logic.

Paolo

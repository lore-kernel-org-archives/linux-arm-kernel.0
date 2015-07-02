From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 2 Jul 2015 15:41:08 +0200
Subject: [RFC 13/17] KVM: introduce kvm_arch functions for IRQ bypass
In-Reply-To: <1435843047-6327-14-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-14-git-send-email-eric.auger@linaro.org>
Message-ID: <55953F74.4030207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/2015 15:17, Eric Auger wrote:
> +#ifdef CONFIG_IRQ_BYPASS_MANAGER

Please use a separate symbol CONFIG_KVM_HAVE_IRQ_BYPASS.

> +void kvm_arch_add_producer(struct irq_bypass_consumer *,
> +			   struct irq_bypass_producer *);

add_irq_bypass_producer, and so on below.

Paolo

> +void kvm_arch_del_producer(struct irq_bypass_consumer *,
> +			   struct irq_bypass_producer *);
> +void kvm_arch_stop_consumer(struct irq_bypass_consumer *);
> +void kvm_arch_resume_consumer(struct irq_bypass_consumer *);
> +
> +#else
> +void kvm_arch_add_producer(struct irq_bypass_consumer *,
> +			   struct irq_bypass_producer *)
> +{
> +}
> +void kvm_arch_del_producer(struct irq_bypass_consumer *,
> +			   struct irq_bypass_producer *)
> +{
> +}
> +void kvm_arch_stop_consumer(struct irq_bypass_consumer *)
> +{
> +}
> +void kvm_arch_resume_consumer(struct irq_bypass_consumer *)
> +{
> +}

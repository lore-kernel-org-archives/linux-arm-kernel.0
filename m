From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 3 Jul 2015 09:02:44 +0200
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559631C0.4050806@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
 <55953F5F.9090203@redhat.com>
 <E959C4978C3B6342920538CF579893F0025E6C23@SHSMSX104.ccr.corp.intel.com>
 <E959C4978C3B6342920538CF579893F0025E6C38@SHSMSX104.ccr.corp.intel.com>
 <559631C0.4050806@linaro.org>
Message-ID: <55963394.8010401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2015 08:54, Eric Auger wrote:
>> > Oh... we can get gsi from irq_bypass_consumer -> _irqfd -> gsi, so it
>> > is not needed in irq_bypass_consumer. Got it! :)
> The issue I have is that struct _irqfd is local to eventfd.c so it
> cannot be used in archi specific code. Is it acceptable to move it to
> kvm_host.h, naming it something like kvm_kernel_irqfd (as done for
> kvm_kernel_irq_routing_entry)? Would also need to move _irqfd_resampler
> there (kvm_kernel_irqfd_resampler).

Yes, that's okay.  Can you put it in a new header file kvm_irqfd.h though?

Paolo

> irqfd user struct cannot be used in a standalone manner since we miss
> the kvm handle.

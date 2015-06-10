From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 10 Jun 2015 18:38:44 +0300
Subject: IRQFD support with GICv3 ITS (WAS: RE: [PATCH 00/13] arm64: KVM:
 GICv3 ITS emulation)
In-Reply-To: <557842A0.9070503@linaro.org>
References: <042601d0a357$d3cec4d0$7b6c4e70$@samsung.com>
 <557842A0.9070503@linaro.org>
Message-ID: <05db01d0a393$895bf710$9c13e530$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> KVM GSI routing, even if only used for MSI routing then mandates to
> build entries for non MSI IRQs, using irqchip routing entries. Then you
> draw the irqchip.c kvm_irq_routing_table
> chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS] static allocation issue.

 Sorry for this add-on, needed time to look at the code.
 Actually, if we don't use this code at all, and implement our own kvm_set_irq_routing()
and kvm_free_irq_routing(), we don't have to bother about all these limitations.
 The simplest thing to do there would be to store GSI number in struct its_itte. In this
case raising an MSI by GSI would not differ from what i currently do.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

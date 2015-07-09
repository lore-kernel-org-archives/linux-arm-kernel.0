From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 09 Jul 2015 17:37:22 +0300
Subject: [PATCH v2 0/7] KVM: arm/arm64: gsi routing support
In-Reply-To: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
Message-ID: <023601d0ba54$c4d6e020$4e84a060$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> v1 -> v2:
> - user API changed:
>   x devid id passed in kvm_irq_routing_msi
>   x kept the new routing entry type: KVM_IRQ_ROUTING_EXTENDED_MSI

 Andre, you never replied to my last comment to the previous series. Are you going to do the same
change in your MSI API? Otherwise:
1. KVM_IRQ_LINE - we have completely own convention. Well, this was already done before us, we
cannot fix it.
2. KVM_SIGNAL_MSI - we use VALID_DEVID flag plus devid
3. KVM_SET_GSI_ROUTING - we use KVM_IRQ_ROUTING_EXTENDED_MSI plus devid

 Don't (2) and (3) together still look bad? Since we agreed on not using flags, i would suggest to
have KVM_SIGNAL_EXTENDED_MSI counterpart, which also doesn't use flags.
 I know, we were already talking about it, so, if this gets ignored for the second time, i assume
the Architects decided that fancy APIs are cool, and i promise to stop this.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

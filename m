From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 06 Jul 2015 09:42:43 +0300
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <5596503E.6040902@arm.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com> <5596503E.6040902@arm.com>
Message-ID: <00fd01d0b7b6$f6cf3550$e46d9ff0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> I like this approach, but it runs into problems:
> As you read above the current documentation says that the flags field
> must be zero and the current KVM_SET_GSI_ROUTING handler bails out if it
> isn't. So userland would need to know whether it's safe to set that
> field.

 This problem does not exist because:
a) Older platforms do not need this flag, so they expect to get zero.
b) ARM64 + GICv3 platform cannot work without this flag.

 This is perfectly OK combination IMO. Userland just knows, whether it needs to supply device ID or
not. For example, my modified qemu now has kvm_msi_flags global variable which defaults to 0. ITS
code, then, if activated, changes it to KVM_MSI_VALID_DEVID, and qemu starts supplying device IDs to
the related calls.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 6 Jul 2015 17:54:55 +0200
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <559AA0D6.7070703@arm.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com> <5596503E.6040902@arm.com>
 <00fd01d0b7b6$f6cf3550$e46d9ff0$@samsung.com> <559A3C9C.6050302@arm.com>
 <20150706093026.GA11590@cbox> <559A52E6.5050402@arm.com>
 <20150706103755.GC11590@cbox> <559A6164.1000401@redhat.com>
 <559A6527.1040107@arm.com> <559A6BBC.2040901@redhat.com>
 <024301d0b7f0$2b13b410$813b1c30$@samsung.com> <559AA0D6.7070703@arm.com>
Message-ID: <559AA4CF.7060300@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/2015 17:37, Andre Przywara wrote:
> Wouldn't:
>     if (kvm_vm_check_extension(s, KVM_CAP_MSI_DEVID)) {
>         kroute.flags = KVM_MSI_VALID_DEVID;
>         kroute.u.msi.devid = (pci_bus_num(dev->bus) << 8) | dev->devfn;
>     }
> 
> be saner (without a global variable)?
> That would make the interface more consistent, with a new flag being
> protected by a new capability.

I agree that your version is niceer, but you still need to cache the
kvm_vm_check_extension result... in a global variable. :)

Paolo

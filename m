From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 15 Jul 2015 13:01:34 +0300
Subject: [PATCH v2 15/15] KVM: arm64: enable ITS emulation as a virtual MSI
 controller
In-Reply-To: <55A62D50.9080101@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-16-git-send-email-andre.przywara@arm.com>
 <00fa01d0bede$098f5570$1cae0050$@samsung.com> <55A62D50.9080101@arm.com>
Message-ID: <012501d0bee5$3b9f2ca0$b2dd85e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> But why would it need the capability to create models?

 Actually it doesn't.

> The idea is to
> check the capability before the actual KVM_SIGNAL_MSI or
> KVM_SET_GSI_ROUTING ioctl (and cache that result). I have a function
> with a static variable to do that, so it looks like:
> 
> +  if (check_for_msi_devid(kvm)) {
> +    irq_routing->entries[irq_routing->nr].flags = KVM_MSI_VALID_DEVID;
> +    irq_routing->entries[irq_routing->nr].u.msi.devid = device_id;
> +  }
> 
> > May be we should just set the capability to TRUE for
> > ARM architecture in general, and make GICv2m MSIs simply ignoring this flag and device ID?
> 
> Possibly, but it would be saner to tell userland that it's a per VM
> decision for ARM. Since you need extra support bits in the userland
> anyway (to set up GICv2M or ITS emulation), I think it is acceptable to
> require a late, per-VM capability check in userland in that case.

 Well, agree, and formally this is more correct. Just it would require slightly more additions to
qemu. But it's not a real problem.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

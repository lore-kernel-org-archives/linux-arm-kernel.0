From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 02 Jul 2015 18:37:55 +0300
Subject: [PATCH 7/7] KVM: arm: implement kvm_set_msi by gsi direct mapping
In-Reply-To: <55955290.1030009@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-8-git-send-email-eric.auger@linaro.org>
 <015501d0b49c$1f1349c0$5d39dd40$@samsung.com> <55955290.1030009@linaro.org>
Message-ID: <02ea01d0b4dd$1186e690$3494b3b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >  Given API change i suggest (using KVM_MSI_VALID_DEVID flag), we could get rid of all these
if()'s
> > here. Just forward all parameters to vGIC implementation code and let it do its checks.
> I don't understand this comment. Here this is the kernel struct that is
> used (struct kvm_kernel_irq_routing_entry) and not the user one
> (kvm_irq_routing_entry). The kernel struct does not have the flag field.

  Easy. ARM code can always use struct kvm_extended_msi, and flags can go to this structure.

> Another reason I think to keep using the type for homogeneity.

 Homogeneity is perfect IMHO.
 If that would be simpler for you, i could post a patch for this which i made on top of your series.
Sorry, i don't have time to respin the whole thing, busy with qemu GICv3 fight :)

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

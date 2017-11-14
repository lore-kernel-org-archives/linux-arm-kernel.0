From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 14 Nov 2017 15:47:52 +0900
Subject: [RFC] kvm: vgic: are these warnings wrong?
Message-ID: <20171114064750.GB29552@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I've just run a static analyzer to v4.14.
While most of warnings/errors are false-positive, as you can easily imagine,
there are something dubious. Can you please check ones below?

virt/kvm/arm/vgic/vgic-v3.c:352 vgic_v3_save_pending_tables() error: uninitialized symbol 'val'.
virt/kvm/arm/vgic/vgic-its.c:424 its_sync_lpi_pending_table() error: uninitialized symbol 'pendmask'.
virt/kvm/arm/vgic/vgic-its.c:779 vgic_its_alloc_collection() error: potential null dereference 'collection'.  (kzalloc returns null)
virt/kvm/arm/vgic/vgic-irqfd.c:115 kvm_vgic_setup_default_irq_routing() warn: double check that we're allocating correct size: 48 vs 64

# I believe that the messages here are self-describing.

Thanks,
-Takahiro AKASHI

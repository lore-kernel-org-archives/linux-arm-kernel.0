From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 26 Aug 2010 15:43:29 +0800
Subject: Driver supported smp linux kernel need use smp_wmb/smp_rmb,
	nor wmb/rmb?
Message-ID: <AANLkTimOaRrEGCYH6k_3wfDixnk1RkJ5JCSi_hv8PQsC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Start with linux 2.6.33,  the DMA coherent buffers are mapped as Normal
Non-cacheable, so our drivers using dma_alloc_coherent() add the
barriers (e.g. wmb/rmb) to ensure that read/wirte coherence with
devices.

Now our drivers are stable at the non-smp linux 2.6.33,  if our driver
need support the smp linux 2.6.33, we need replace wmb()/rmb() to
smp_wmb()/smp_rmb()?


Thank for any help

David

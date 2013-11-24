From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 25 Nov 2013 00:22:47 +0200
Subject: ARM: v3.13-rc1: USB regression
Message-ID: <20131124222247.GC24645@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With 3.13-rc1, the USB OHCI probe fails on Amstrad E3 (ARM/OMAP1)
as follows:

[   33.814705] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   33.821482] ohci-omap: OHCI OMAP driver
[   33.925153] ohci ohci: OMAP OHCI
[   33.929087] ohci ohci: new USB bus registered, assigned bus number 1
[   33.967324] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
[   33.982292] ohci ohci: can't setup: -12
[   33.987898] ohci ohci: USB bus 1 deregistered
[   33.992984] ohci: probe of ohci failed with error -12

I bisected this to 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 (ARM: DMA-API:
better handing of DMA masks for coherent allocations). Reverting that
commit makes the USB work again fine.

A.

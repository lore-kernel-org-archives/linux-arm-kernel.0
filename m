From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 14:51:28 +0000
Subject: [Xen-devel] [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with
 virt extensions
In-Reply-To: <201111301432.54463.arnd@arndb.de>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <201111301303.23851.arnd@arndb.de>
 <1322659535.31810.97.camel@zakaz.uk.xensource.com>
 <201111301432.54463.arnd@arndb.de>
Message-ID: <1322664688.3180.6.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 14:32 +0000, Arnd Bergmann wrote:
> I don't care much either way, but I think it would be good to
> use similar solutions across all hypervisors. The two options
> that I've seen discussed for KVM were to use either a virtual PCI
> bus with individual virtio-pci devices as on the PC, or to
> use the new virtio-mmio driver and individually put virtio devices
> into the device tree.

Let me just add that the virtio-mmio devices can already be instantiated
from DT (see Documentation/devicetree/bindings/virtio/mmio.txt).

For A9-based VE I'd suggest placing them around 0x1001e000, eg.:

        virtio_block at 1001e000 {
                compatible = "virtio,mmio";
                reg = <0x1001e000 0x100>;
                interrupts = <41>;
        }

Cheers!

Pawe?

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 10:08:46 +0200
Subject: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for Mediatek
 PCIe
In-Reply-To: <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
Message-ID: <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 4:07 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:

> +- ranges:
> +  - The first three entries are expected to translate the addresses for the root
> +    port registers, which are referenced by the assigned-addresses property of
> +    the root port nodes (see below).

I don't understand this part. Why do you need a static translation for these?
Shouldn't they just be listed in the 'reg' property of the parent node now that
you have the clk/reset/phy properties in the parent as well?

> +Required properties:
> +- device_type: Must be "pci"
> +- assigned-addresses: Address and size of the port configuration registers
> +- reg: Only the first four bytes are used to refer to the correct bus number
> +  and device number.
> +- #address-cells: Must be 3
> +- #size-cells: Must be 2
> +- #interrupt-cells: Must be 1
> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> +  Please refer to the standard PCI bus binding document for a more detailed
> +  explanation.

Child nodes do not normally have interrupt-map properties. Isn't this
already covered by the interrupt-map in the parent?

      Arnd

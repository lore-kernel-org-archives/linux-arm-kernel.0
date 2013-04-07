From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 7 Apr 2013 20:43:37 +0200
Subject: [PATCH 11/11] RFC: ARM: get PCI device IRQs from device tree
In-Reply-To: <201304041527.52400.arnd@arndb.de>
References: <1365087696-9548-1-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-11-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-12-git-send-email-linus.walleij@linaro.org>
 <201304041527.52400.arnd@arndb.de>
Message-ID: <CACRpkdYYmVpQkKngQSt-mQbhE=PXcy1U8P735Ws6tqw55nWvmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 5:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 April 2013, Linus Walleij wrote:
>> This adds the interrupt-map property to the PCIv3 DTS file
>> and makes the bridge obtain mappings from the device tree.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> This currently bugs out - when trying to get the IRQs for
>> devices of_irq_map_pci() reads the IRQ pin from the PCI config
>> space successfully, then comes to trying to look up the parent
>> PCI device by checking pdev->bus->self, which is NULL, then
>> tries to treat it as a bridge doing pci_bus_to_OF_node(pdev->bus)
>> which also results in NULL and it bails out.
>>
>> No clue why this is so - some problem with the parent of this
>> bus not being a PCI device in itself? Help.
>
> All the PowerPC implementations I remember had the PCI bus
> as a device under the root node. It's very possible that it's
> just a bug in of_irq_map_pci().

Hm, quite hard to figure this one out.

Benjamin, any hints?

Yours,
Linus Walleij

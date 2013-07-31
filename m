From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 31 Jul 2013 10:26:44 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130731100359.3e789236@skate>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
Message-ID: <51F8CA44.4080802@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 07/31/2013 10:03 AM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,
>
> On Wed, 10 Jul 2013 18:15:32 +0200, Gerlando Falauto wrote:
>
>> I am trying to use the pci-mvebu driver on one of our km_kirkwood
>> boards. The board is based on Marvell's 98dx4122, which should
>> essentially be 6281 compatible.
>
> In the end, did you manage to get the pci-mvebu driver to work on your
> platform?

Yes, I did -- though I didn't go much beyond simple device probing (i.e. 
no real, intense usage of devices). AND I'm not using the DT-based mbus 
driver (i.e. addresses are still hardcoded within the source code).

Actually, the main reason for trying to use this driver was because I 
wanted to model a PCIe *device* within the device tree, so to expose its 
GPIOs and IRQs to be referenced (through phandles) from other device 
tree nodes. The way I understand it, turns out this is not the way to 
go, as PCI/PCIe are essentially enumerated busses, so you're not 
supposed to -and it's not a trivial task to- put any information about 
real devices within the device tree.
Do you have any suggestion about that?

On the other hand, for our use case I'm afraid there might be some 
hardcoded values within drivers or userspace code, where a certain PCIe 
device is expected to be connected within a given bus number with a 
given device number (bleah!).
If I understand correctly, your driver creates a virtual PCI-to-PCI 
bridge, so our devices would be connected to BUS #1 as opposed to #0 -- 
which might break existing (cr*ee*ppy) code.
But that's not your fault of course.

If you're interested, I can keep you posted as soon as we proceed 
further with this (most likely in September or so).

Next step would be to test Ezequiel's MBus DT binding [PATCH v8], but 
I'm afraid that'll have to wait too, until end of August or so, as I am 
about to leave for vacation.

Thank you!
Gerlando

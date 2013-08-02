From: finn@uni-bremen.de (Finn Hoffmann)
Date: Fri, 02 Aug 2013 10:35:37 +0200
Subject: NSA310 + DT
In-Reply-To: <20130731115108.21c043fd@skate>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
 <20130730232316.10dc7019@skate> <20130731111414.47e7670b@skate>
 <51F8DC3A.6010007@uni-bremen.de> <20130731115108.21c043fd@skate>
Message-ID: <51FB6F59.4010205@uni-bremen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 31.07.2013 11:51, schrieb Thomas Petazzoni:
> Dear Finn Hoffmann,
>
> On Wed, 31 Jul 2013 11:43:22 +0200, Finn Hoffmann wrote:
>
>> Hi Thomas,
>> here you are.
>> Network is working.
> Excellent, thanks!
>
>> # cat /sys/kernel/debug/mvebu-mbus/devices
>> [00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap
>> 0000000000010000) [01] disabled
>> [02] disabled
>> [03] disabled
>> [04] 00000000f4000000 - 00000000f4010000 : nand
>> [05] 00000000f5000000 - 00000000f5010000 : sram
>> [06] 00000000e0000000 - 00000000e0100000 : pcie0.0
>> [07] disabled
> Now this looks good, we have both the PCIe memory and PCIe I/O windows
> created.
>
> I'll clean up the patch and send it, hopefully for the final 3.11.
>
> Thanks again for all your testing!
>
> Best regards,
>
> Thomas
Thomas,

I just came across one thing. Is it ok that I have different Marvell 
device with patched 3.11.0-rc3?
With 3.10.2 it has pci id 11ab:6281, with 3.11.0-rc3 and your patch it 
has 11ab:7846.

Finn

3.10.2:

# lspci -vnn
00:00.0 Host bridge [0600]: Marvell Technology Group Ltd. 88F6281 
[Kirkwood] ARM SoC [11ab:6281] (rev 03)
     Subsystem: Marvell Technology Group Ltd. Device [11ab:11ab]
     Flags: bus master, fast devsel, latency 0, IRQ 9
     Memory at <ignored> (64-bit, prefetchable)
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [60] Express Root Port (Slot-), MSI 00
     Capabilities: [100] Advanced Error Reporting

00:01.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 03)
     Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit PCI-E 
Adapter [Trendnet] [10ec:8168]
     Flags: bus master, fast devsel, latency 0, IRQ 9
     I/O ports at 1000 [size=256]
     Memory at e0014000 (64-bit, prefetchable) [size=4K]
     Memory at e0010000 (64-bit, prefetchable) [size=16K]
     [virtual] Expansion ROM at e0000000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [70] Express Endpoint, MSI 01
     Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
     Capabilities: [cc] Vital Product Data
     Capabilities: [100] Advanced Error Reporting
     Capabilities: [140] Virtual Channel
     Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: r8169

3.11.0-rc3:
lspci -vnn
00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device 
[11ab:7846] (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 00010000-00010fff
     Memory behind bridge: e0000000-e00fffff
     Prefetchable memory behind bridge: 00000000-000fffff

01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 03)
     Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit PCI-E 
Adapter [Trendnet] [10ec:8168]
     Flags: bus master, fast devsel, latency 0, IRQ 9
     I/O ports at 10000 [size=256]
     Memory at e0014000 (64-bit, prefetchable) [size=4K]
     Memory at e0010000 (64-bit, prefetchable) [size=16K]
     [virtual] Expansion ROM at e0000000 [disabled] [size=64K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [70] Express Endpoint, MSI 01
     Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
     Capabilities: [cc] Vital Product Data
     Capabilities: [100] Advanced Error Reporting
     Capabilities: [140] Virtual Channel
     Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
     Kernel driver in use: r8169

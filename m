From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 May 2013 15:47:37 +0200
Subject: [PATCH] arm: mvebu: enable the third USB interface on OpenBlocks
 AX3
In-Reply-To: <20130517.111810.02327269.yamagata@plathome.co.jp>
References: <1368720444-29357-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130517.111810.02327269.yamagata@plathome.co.jp>
Message-ID: <519634F9.7060700@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
On 05/17/2013 04:18 AM, yamagata at plathome.co.jp wrote:
> Dear Mr. Petazzoni
> 
>> Besides the two "classic" USB interfaces with normal USB ports on the
>> front side, the PlatHome OpenBlocks AX3 uses the third USB interface
>> of the Marvell SoC in the mini-PCIe connector. This allows certain
>> mini-PCIe cards to expose parts of their functionality as a USB
>> peripheral.
>>
>> This commit enables this third USB interface in the OpenBlocks AX3
>> Device Tree, and also adds comments on top of the two other USB
>> interfaces so that the Device Tree makes it clear which USB interface
>> at the SoC level matches which USB interface visible on the board.
> 
> I see the following messages by dmesg with your patch for
> linux-3.10-rc1 and 3.9.2.
> 
> ...
> usb 3-1: New USB device found, idVendor=0a5c, idProduct=219c
> usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-1: Product: Broadcom BCM2070 Bluetooth Device
> usb 3-1: Manufacturer: Broadcom Corp
> usb 3-1: SerialNumber: B4749F63C1B6
> ...
> Bluetooth: Core ver 2.16
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> usbcore: registered new interface driver btusb

This patch is nice and adds useful information.

I applied and tested on my OpenBlocks AX3 and get the 3rd USB
interface detected. As I don't have any mini-PCIe card which use USB,
I didn't tested it furthermore, but as Atsushi Yamagata managed to
detect an USB device on this interface, we can be pretty confident
with this patch:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

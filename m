From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 31 Oct 2010 20:08:33 +0100
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit
	5bc23d32d
In-Reply-To: <20101031190034.GZ15069@ibawizard.net>
References: <20101031182157.GY15069@ibawizard.net>
	<20101031183140.GA30636@n2100.arm.linux.org.uk>
	<20101031190034.GZ15069@ibawizard.net>
Message-ID: <20101031190833.GA15069@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr ?tetiar <ynezz@true.cz> [2010-10-31 20:00:34]:

> 	root at ts72xx:~# ifup ra0
> 	WPA: Configuring Interface
> 	[   30.900000] arm_vmregion_alloc() size: 33000
> 	[   30.910000] arm_vmregion_alloc() found: start: 4291297280 end: 4291506176 size: 33000
> 	[   30.920000] arm_vmregion_alloc() size: 33000
> 	[   30.930000] arm_vmregion_alloc() found: start: 4291821568 end: 4292030464 size: 33000
> 	[   30.940000] arm_vmregion_alloc() size: 33000
> 	[   30.950000] arm_vmregion_alloc() found: start: 4292345856 end: 4292554752 size: 33000
> 	[   30.960000] arm_vmregion_alloc() size: 33000
> 	[   30.970000] arm_vmregion_alloc() no space!
> 	[   30.970000] <-- ERROR in Alloc TX TxContext[3] HTTX_BUFFER !!

Adding vmregion allocs in boot:

[    2.270000] Registering the dns_resolver key type
[    2.780000] arm_vmregion_alloc() size: 1000
[    2.780000] arm_vmregion_alloc() found: start: 4290772992 end: 4290777088 size: 1000
[    3.810000] IP-Config: Guessing netmask 255.255.255.0
[    3.810000] IP-Config: Complete:
[    3.810000]      device=eth0, addr=192.168.1.10, mask=255.255.255.0, gw=255.255.255.255,
[    3.830000]      host=192.168.1.10, domain=, nis-domain=(none),
[    3.840000]      bootserver=255.255.255.255, rootserver=192.168.1.90, rootpath=
[    3.850000] Looking up port of RPC 100003/2 on 192.168.1.90
[    3.860000] Looking up port of RPC 100005/1 on 192.168.1.90
[    3.870000] VFS: Mounted root (nfs filesystem) on device 0:13.
[    3.890000] devtmpfs: mounted
[    3.890000] Freeing init memory: 112K
[    4.210000] PHY: 0:01 - Link is Up - 100/Full
INIT: version 2.86 booting
Please wait: booting...
Starting udev
[    7.040000] udevd (48): /proc/48/oom_adj is deprecated, please use /proc/48/oom_score_adj instead.
[   11.080000] ep93xx-rtc ep93xx-rtc: rtc core: registered ep93xx-rtc as rtc0
[   12.840000] rtc-m48t86 rtc-m48t86: rtc core: registered m48t86 as rtc1
[   12.950000] rtc-m48t86 rtc-m48t86: battery ok
[   14.410000] usbcore: registered new interface driver usbfs
[   14.410000] usbcore: registered new interface driver hub
[   14.470000] usbcore: registered new device driver usb
[   14.560000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   14.580000] ep93xx-ohci ep93xx-ohci: EP93xx OHCI
[   14.580000] ep93xx-ohci ep93xx-ohci: new USB bus registered, assigned bus number 1
[   14.600000] ep93xx-ohci ep93xx-ohci: irq 56, io mem 0x80020000
[   14.610000] arm_vmregion_alloc() size: 1000
[   14.610000] arm_vmregion_alloc() found: start: 4290781184 end: 4290785280 size: 1000
[   14.680000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   14.690000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.690000] usb usb1: Product: EP93xx OHCI
[   14.710000] usb usb1: Manufacturer: Linux 2.6.36+ ohci_hcd
[   14.710000] usb usb1: SerialNumber: ep93xx
[   14.720000] hub 1-0:1.0: USB hub found
[   14.730000] hub 1-0:1.0: 3 ports detected
[   15.070000] usb 1-1: new full speed USB device using ep93xx-ohci and address 2
[   15.070000] arm_vmregion_alloc() size: 1000
[   15.070000] arm_vmregion_alloc() found: start: 4290789376 end: 4290793472 size: 1000
[   15.070000] arm_vmregion_alloc() size: 1000
[   15.070000] arm_vmregion_alloc() found: start: 4290797568 end: 4290801664 size: 1000
Remounting root file system...

-- ynezz

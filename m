From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Thu, 11 Jun 2015 11:42:27 +0200
Subject: [BUG] usb/at91: usb hub does not work
Message-ID: <55795803.30302@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I discovered some bug when I change kernel from 3.18.13 to 3.18.14. I have board with usb hub CY7C65632 on it.
In .13 it works fine but in .14 it repeats this message:
[   19.170000] usb 2-3: new full-speed USB device number 56 using at91_ohci
and devices connected to usb through hub doesn't appear at all.

Here is dmesg | grep usb of .14:
[    3.220000] usbcore: registered new interface driver usbfs
[    3.220000] usbcore: registered new interface driver hub
[    3.220000] usbcore: registered new device driver usb
[    4.630000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.640000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.650000] usb usb1: Product: EHCI Host Controller
[    4.650000] usb usb1: Manufacturer: Linux 3.18.14_cpm9g25 ehci_hcd
[    4.660000] usb usb1: SerialNumber: 700000.ehci
[    4.770000] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    4.780000] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.780000] usb usb2: Product: OHCI Host Controller
[    4.790000] usb usb2: Manufacturer: Linux 3.18.14_cpm9g25 ohci_hcd
[    4.800000] usb usb2: SerialNumber: at91
[    4.840000] usbcore: registered new interface driver cdc_acm
[    4.850000] usbcore: registered new interface driver usb-storage
[    4.860000] atmel_usba_udc 500000.gadget: MMIO registers at 0xf803c000 mapped at c8888000
[    4.870000] atmel_usba_udc 500000.gadget: FIFO at 0x00500000 mapped at c8900000
[    4.890000] usb0: HOST MAC f2:a5:c3:38:f9:a3
[    4.900000] usb0: MAC e2:fb:4b:4a:b7:97
[    5.640000] usb 2-3: new full-speed USB device number 4 using at91_ohci
[    7.760000] usb 2-3: new full-speed USB device number 12 using at91_ohci
[   10.780000] usb 2-3: new full-speed USB device number 24 using at91_ohci
[   12.360000] usb 2-3: new full-speed USB device number 30 using at91_ohci
[   13.940000] usb 2-3: new full-speed USB device number 36 using at91_ohci
[   15.040000] usb 2-3: new full-speed USB device number 40 using at91_ohci
[   17.580000] usb 2-3: new full-speed USB device number 50 using at91_ohci
...

and here of .13:
[    3.200000] usbcore: registered new interface driver usbfs
[    3.210000] usbcore: registered new interface driver hub
[    3.210000] usbcore: registered new device driver usb
[    4.630000] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.640000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.650000] usb usb1: Product: EHCI Host Controller
[    4.650000] usb usb1: Manufacturer: Linux 3.18.13_cpm9g25 ehci_hcd
[    4.660000] usb usb1: SerialNumber: 700000.ehci
[    4.770000] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    4.780000] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.780000] usb usb2: Product: OHCI Host Controller
[    4.790000] usb usb2: Manufacturer: Linux 3.18.13_cpm9g25 ohci_hcd
[    4.800000] usb usb2: SerialNumber: at91
[    4.840000] usbcore: registered new interface driver cdc_acm
[    4.850000] usbcore: registered new interface driver usb-storage
[    4.860000] atmel_usba_udc 500000.gadget: MMIO registers at 0xf803c000 mapped at c8888000
[    4.870000] atmel_usba_udc 500000.gadget: FIFO at 0x00500000 mapped at c8900000
[    4.890000] usb0: HOST MAC de:5f:a8:09:26:b6
[    4.900000] usb0: MAC 8a:a9:f8:36:9f:12
[    5.200000] usb 2-3: new full-speed USB device number 2 using at91_ohci
[    5.410000] usb 2-3: not running at top speed; connect to a high speed hub
[    5.420000] usb 2-3: New USB device found, idVendor=04b4, idProduct=6570
[    5.450000] usb 2-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.450000] usb 2-3: Product: USB2.0 Hub

but in .14 other external noname hub on ehci works:
[   23.420000] usb 1-2: New USB device found, idVendor=04b4, idProduct=6560
[   23.420000] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   23.430000] hub 1-2:1.0: USB hub found
[   23.460000] hub 1-2:1.0: 4 ports detected

Any idea?

Thanks
Jiri

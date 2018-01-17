From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 Jan 2018 19:19:18 +0100 (CET)
Subject: mmc1 timeout issue with rpi3
In-Reply-To: <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
References: <5d800b63-d45d-d4e4-214c-3ebf602c79e9@orpaltech.com>
 <1059643032.72553.1516136078614@email.1und1.de>
 <5ab12aa4-57a9-55b5-ef43-43b2eac9c1b7@orpaltech.com>
Message-ID: <1199109167.10232.1516213158515@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

> Sergey Suloev <ssuloev@orpaltech.com> hat am 16. Januar 2018 um 22:07 geschrieben:
> 
> 
> sure, here you go
> 
> https://pastebin.com/kAHUrb6m
> 
> 
> On 01/16/2018 11:54 PM, Stefan Wahren wrote:
> > Hi Sergey,
> >
> >> Sergey Suloev <ssuloev@orpaltech.com> hat am 16. Januar 2018 um 21:27 geschrieben:
> >>
> >>
> >> Hi,
> >> I still have the issue "mmc1 timeout" with mainline 4.15rc7, discussed here
> >>
> >> http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-June/004003.html
> >>
> >> Is there any progress on this ?
> >> Thanks
> >>
> > please provide the dmesg output.

first of all please avoid top-posting.

These mmc1 timeouts are unexpected for Raspberry Pi 3 with mailine kernel. I'm using multi_v7_defconfig and get the following:

[    0.730597] mmc1: SDHCI controller on 3f300000.sdhci [3f300000.sdhci] using PIO
[    0.738238] ledtrig-cpu: registered to indicate activity on CPUs
[    0.745085] usbcore: registered new interface driver usbhid
[    0.751536] usbhid: USB HID core driver
[    0.758625] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    0.767760] NET: Registered protocol family 10
[    0.775301] Segment Routing with IPv6
[    0.781785] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.788874] NET: Registered protocol family 17
[    0.795399] can: controller area network core (rev 20170425 abi 9)
[    0.802013] NET: Registered protocol family 29
[    0.808495] can: raw protocol (rev 20170425)
[    0.814965] can: broadcast manager protocol (rev 20170425 t)
[    0.821447] can: netlink gateway (rev 20170425) max_hops=1
[    0.828317] Key type dns_resolver registered
[    0.835733] Registering SWP/SWPB emulation handler
[    0.842787] Loading compiled-in X.509 certificates
[    0.852989] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 87, base_baud = 0) is a PL011 rev2
[    0.862190] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.868970] raspberrypi-firmware soc:firmware: Attached to firmware from 2017-07-03 14:16
[    0.870688] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.872371] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.875388] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.897742] mmc0: host does not support reading read-only switch, assuming write-enable
[    0.906523] mmc0: new high speed SDHC card at address 1234
[    0.913738] mmcblk0: mmc0:1234 SA32G 29.3 GiB 
[    0.922210]  mmcblk0: p1 p2
[    0.928980] dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found, using dummy regulator
[    0.935881] dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found, using dummy regulator
[    0.993219] dwc2 3f980000.usb: DWC OTG Controller
[    0.999967] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
[    1.002026] mmc1: new high speed SDIO card at address 0001

Could you please also share your config?
Do you have a Raspberry Pi 3 B 1.2?
Did you check the function of the hardware before?

> >
> > Stefan
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

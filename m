From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Tue, 1 Dec 2009 12:16:03 -0200
Subject: USB support on i.MX27
In-Reply-To: <37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
	<20091127101654.GP14091@buzzloop.caiaq.de>
	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
	<37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>
Message-ID: <37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/30/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> I forgot to comment, I am configuring usbh2's portsc as on mx31lite:
>
> .portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
>
> I defined and configured usbh2 pins:
>         /* USBH2 */
>         PA0_PF_USBH2_CLK,
>         PA1_PF_USBH2_DIR,
>         PA3_PF_USBH2_NXT,
>         PA4_PF_USBH2_STP,
>         PD22_AF_USBH2_DATA0,
>         PD24_AF_USBH2_DATA1,
>         PD23_AF_USBH2_DATA2,
>         PD20_AF_USBH2_DATA3,
>         PD19_AF_USBH2_DATA4,
>         PD26_AF_USBH2_DATA5,
>         PD21_AF_USBH2_DATA6,
>         PA2_PF_USBH2_DATA7,
>         PA24_AIN_SLDCD1_D0, /* EN_B */
>         PA26_PF_PS, /* RES_B */
>
> What you think could be this issue?
>

More some debug and everything worked fine:

FEC Ethernet Driver
fec: PHY @ 0x0, ID 0x0007c0f1 -- LAN8710
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.1: irq 54, io mem 0x10024200
mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.32-rc6-g415c7d2-dirty ehci_hcd
usb usb1: SerialNumber: mxc-ehci.1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
ULPI transceiver vendor/product ID 0x04cc/0x1504
mxc-ehci mxc-ehci.2: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.2: new USB bus registered, assigned bus number 2
mxc-ehci mxc-ehci.2: irq 55, io mem 0x10024400
mxc-ehci mxc-ehci.2: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Freescale On-Chip EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.32-rc6-g415c7d2-dirty ehci_hcd
usb usb2: SerialNumber: mxc-ehci.2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
hub 1-0:1.0: over-current change on port 1

Best Regards,

Alan

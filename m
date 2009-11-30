From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 30 Nov 2009 17:57:07 -0200
Subject: USB support on i.MX27
In-Reply-To: <37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
	<20091127101654.GP14091@buzzloop.caiaq.de>
	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
Message-ID: <37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On 11/30/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
>
> USB Host1 worked fine, but USB Host2 (connected to ISP1504) is crashing:
>
> FEC Ethernet Driver
> fec: PHY @ 0x3, ID 0x0007c0f1 -- LAN8710
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
> mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
> mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
> mxc-ehci mxc-ehci.1: irq 54, io mem 0x10024200
> mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
> timeout polling for ULPI device
> timeout polling for ULPI device
> timeout polling for ULPI device
> timeout polling for ULPI device
> ULPI transceiver vendor/product ID 0xffffff92/0xffffff92
> ULPI ID does not match any known transceiver.
> mxc-ehci mxc-ehci.2: unable to init transceiver
> mxc-ehci mxc-ehci.2: Freescale On-Chip EHCI Host Controller
> mxc-ehci mxc-ehci.2: new USB bus registered, assigned bus number 2
> Unhandled fault: external abort on non-linefetch (0x808) at 0xc8896584
> Internal error: : 808 [#1] PREEMPT
>...

I forgot to comment, I am configuring usbh2's portsc as on mx31lite:

.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,

I defined and configured usbh2 pins:
        /* USBH2 */
        PA0_PF_USBH2_CLK,
        PA1_PF_USBH2_DIR,
        PA3_PF_USBH2_NXT,
        PA4_PF_USBH2_STP,
        PD22_AF_USBH2_DATA0,
        PD24_AF_USBH2_DATA1,
        PD23_AF_USBH2_DATA2,
        PD20_AF_USBH2_DATA3,
        PD19_AF_USBH2_DATA4,
        PD26_AF_USBH2_DATA5,
        PD21_AF_USBH2_DATA6,
        PA2_PF_USBH2_DATA7,
        PA24_AIN_SLDCD1_D0, /* EN_B */
        PA26_PF_PS, /* RES_B */

What you think could be this issue?

Thank you very much,

Alan

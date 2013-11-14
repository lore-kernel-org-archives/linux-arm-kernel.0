From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Nov 2013 09:45:05 -0600
Subject: [Inquiry] How to boot using USB device and configure PCI using
 OMAP4460/4470?
In-Reply-To: <CAB8gEUt-_-w4wJkdo3bH7qiLOaqFusfL85rs58n00twD1qpxLA@mail.gmail.com>
References: <CAB8gEUt-_-w4wJkdo3bH7qiLOaqFusfL85rs58n00twD1qpxLA@mail.gmail.com>
Message-ID: <20131114154505.GC15835@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 14, 2013 at 01:34:14PM +0800, Maggie Mae Roxas wrote:
> Hello,
> Good day.
> 
> I am currently developing a Panda board that uses OMAP4460/4470.
> I have two questions.
> 
> 1) I can boot it via SD.
> But I would like to boot it using USB device connected in one of the 2 USB
> ports (not from PC via USB connection).
> Can you guide me on how to do this?
> # I found some forums and howtos, but it discusses the usbboot (PC via USB
> connection type of boot), which is not what I need..

all you need to do is write a flasher and a small "bootloader" which
knows about usb. ROM code can receive data via USB and jump to that
data's entry point.

It's all in the TRM.

> 2) I have customized the actual board to have PCI connection, however, I
> found out that OMAP kernel configurations does not support PCI (I am not
> sure if u-boot does).

that's because OMAP4 doesn't have a PCI controller.

> BTW, I am using Linux Kernel v3.0, Android FS v4.3, Marvell U-Boot 1.1-4

you're on your own, sorry. You need to ask for support from whoever gave
you that v3.0 kernel.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/68edf4b7/attachment.sig>

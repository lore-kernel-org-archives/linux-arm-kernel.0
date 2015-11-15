From: dgilbert@interlog.com (Douglas Gilbert)
Date: Sat, 14 Nov 2015 19:02:54 -0500
Subject: [PATCH] Atmel USB High speed device port, speed fix
Message-ID: <5647CBAE.4070908@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following changes that appeared in lk 4.0.0, the gadget udc driver for
some ARM based Atmel SoCs (e.g. at91sam9x5 and sama5d3 families)
incorrectly deduced full-speed USB link speed even when the hardware
had negotiated a high-speed link. The fix is to make sure that the
UDPHS Interrupt Enable Register value does not mask the SPEED bit
in the Interrupt Status Register.

For a mass storage gadget this problem lead to failures when the host
had a USB 3 port with the xhci_hcd driver. If the host was a USB 2
port using the ehci_hcd driver then the mass storage gadget worked
(but probably at a lower speed than it should have).


Signed-of-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: <stable@vger.kernel.org> #4.0+
-------------- next part --------------
A non-text attachment was scrubbed...
Name: atmel_udhs_int_mask.patch
Type: text/x-patch
Size: 553 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151114/264e3f38/attachment.bin>

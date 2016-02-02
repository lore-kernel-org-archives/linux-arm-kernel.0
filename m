From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 02 Feb 2016 10:06:30 +0200
Subject: [PATCH] usb: xhci: fix build error for USB_SPEED_SUPER_PLUS
In-Reply-To: <1508874.HIZbDSzAVR@wuerfel>
References: <1508874.HIZbDSzAVR@wuerfel>
Message-ID: <56B06386.6030002@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.02.2016 18:18, Arnd Bergmann wrote:
> A recent patch introduced support for superspeed plus (USB3.1), but that
> caused a new gcc warning in the XHCI code:
>
> usb/host/xhci.c: In function 'xhci_drop_ep_from_interval_table':
> usb/host/xhci.c:2440:2: error: enumeration value 'USB_SPEED_SUPER_PLUS' not handled in switch [-Werror=switch]
>
> This changes the XHCI driver to handle USB_SPEED_SUPER_PLUS the
> same way as USB_SPEED_SUPER in the xhci_drop_ep_from_interval_table
> and xhci_add_ep_to_interval_table functions, explicitly ignoring
> it.
>

The original series that added USB_SPEED_SUPER_PLUS to both core and xhci was only partly accepted.
The core part was applied, the rest was asked to  be resubmitted.

Second part is still waiting to be applied.

http://www.spinics.net/lists/linux-usb/msg135493.html

-Mathias

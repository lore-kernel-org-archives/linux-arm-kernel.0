From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 21:53:32 +0100
Subject: [PATCH 2/2] [usb] add support for APM X-Gene to xhci-platform
In-Reply-To: <54529BB5.6020201@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <3416966.BJ3nX0qr78@wuerfel> <54529BB5.6020201@redhat.com>
Message-ID: <40794677.g0SIFeELP2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 15:12:37 Mark Langsdorf wrote:
> > So just remove this symbol and let the user select USB_XHCI_PLATFORM
> 
> USB_XHCI_PLATFORM isn't currently user selectable since it doesn't
> have a string after the tristate. It gets automatically selected by
> USB_XHCI_RCAR and USB_XHCI_MVEBU and I was continuing the pattern.
> Do you want me to make it user selectable instead?

Yes, please do.

The difference is that the two you mentioned have separate driver files
that you may or may not want to have built into your kernel. The APM
support apparently doesn't need any of that and just works with the
common parts of the driver. I expect to see more of those in the
future.

	Arnd

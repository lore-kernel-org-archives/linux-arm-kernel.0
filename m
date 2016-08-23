From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Aug 2016 11:30:04 -0400 (EDT)
Subject: [PATCH v7] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1471914329-14395-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1608231129310.2093-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2016, Wenyou Yang wrote:

> The usb controller does not manage correctly the suspend mode for
> the ehci. In echi mode, there is no way to suspend without any
> device connected to it. This is why this specific control is added
> to fix this issue. Since the suspend mode works in ohci mode, this
> specific control works by suspend the usb controller in ohci mode.
> 
> This specific control is by setting the SUSPEND_A/B/C fields of
> SFR_OHCIICR(OHCI Interrupt Configuration Register) in the SFR
> while the OHCI USB suspend.
> 
> This set operation must be done before the USB clock disabled,
> clear operation after the USB clock enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> 
> Changes in v7:
>  - Rename ohci_at91_port_ctrl() to ohci_at91_port_suspend().
>  - Add check valid_port(wIndex)  before invoke
>    ohci_at91_port_suspend().
>  - Call ohci_at91_port_suspend() directly on suspend/resume
>    operations.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

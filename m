From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 8 Jun 2016 15:13:56 -0400 (EDT)
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1606081352250.2191-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jun 2016, Wenyou Yang wrote:

> In order to the save power consumption, as a workaround, suspend
> forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> 
> This suspend operation must be done before the USB clock is disabled,
> resume after the USB clock is enabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---

You never answered the questions I posted for the first version of this 
patch:

What does this mean?  What does suspending a port do?  Is it the same 
as a normal USB port suspend?

If it is the same, why doesn't the USB_PORT_FEAT_SUSPEND subcase of the 
SetPortFeature case in ohci_hub_control() already take care of this?

Alan Stern

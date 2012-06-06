From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 6 Jun 2012 10:19:59 -0400 (EDT)
Subject: [PATCH v4] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1206061017210.1788-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jun 2012, Richard Zhao wrote:

> It still has below limitations:
> - it does not work for multi-phy ehci
> - the best place is after debounce, but I can't get
>   phy there

> +			/* FIXME:
> +			 * - it does not work for multi-phy ehci
> +			 * - the best place is after debounce, but I can't get
> +			 *   phy there
> +			 */
> +			if (unlikely(ehci->transceiver &&
> +					(pstatus & PORT_CSC))) {

A new thought...  If you move the transceiver pointer from struct 
ehci_hcd to struct usb_hcd, then you _will_ be able to get at it from 
within the debouncing routine.

Or if you prefer, leave the pointer where it is and add a method to 
struct hc_driver for retrieving the pointer.

Alan Stern

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 22:39:15 +0300
Subject: [PATCH 3/4] usb: xhci: plat: Add USB phy support
In-Reply-To: <1420559110-8043-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420559110-8043-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54AC39E3.8050109@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/06/2015 06:45 PM, Maxime Ripard wrote:

> The Marvell Armada 385 AP needs a dumb phy in order to enable the USB3 VBUS.

> Add a call to retrieve a USB PHY to XHCI plat in order to support this.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

[...]

> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index cc7c5bb7cbcf..d9468af2a8e4 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1474,6 +1474,8 @@ struct xhci_hcd {
>   	struct msix_entry	*msix_entries;
>   	/* optional clock */
>   	struct clk		*clk;
> +	/* optional phy */
> +	struct usb_phy		*phy;

    Can't you reuse the one in 'struct usb_hcd'?

[...]

WBR, Sergei

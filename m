From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Aug 2013 10:39:40 -0400 (EDT)
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <1375337800-2605-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1308011038380.1534-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Aug 2013, Boris BREZILLON wrote:

> The AT91 PMC (Power Management Controller) provides an USB clock used by
> USB Full Speed host (ohci) and USB Full Speed device (udc).
> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
> This configuration was formely done in mach-at91/clock.c, but this
> implementation will be removed when moving to common clk framework.
> 
> This patch adds support for usb clock retrieval and configuration, and is
> backward compatible with the current at91 clk implementation (if usb clk
> is not found, it does not configure/enable it).
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

> @@ -163,6 +169,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err5;
>  	}
>  
> +	uclk = clk_get(&pdev->dev, "usb_clk");

What happens if uclk isn't found but it is needed?

Alan Stern

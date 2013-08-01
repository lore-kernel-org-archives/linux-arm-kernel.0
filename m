From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Aug 2013 13:39:59 -0400 (EDT)
Subject: [PATCH v2] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <1375376953-22823-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1308011339460.1534-100000@iolanthe.rowland.org>
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
> Changes since v1:
>  - use IS_ENABLED(CONFIG_COMMON_CLK) to isolate new at91 clk support
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

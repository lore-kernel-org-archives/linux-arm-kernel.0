From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 3 Dec 2015 10:25:25 -0500 (EST)
Subject: [PATCH] USB: host: ohci-at91: fix a crash in
 ohci_hcd_at91_overcurrent_irq
In-Reply-To: <566000A8.7070107@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1512031024210.1761-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Dec 2015, Nicolas Ferre wrote:

> Le 02/12/2015 20:36, Alexandre Belloni a ?crit :
> > The interrupt handler, ohci_hcd_at91_overcurrent_irq may be called right
> > after registration. At that time, pdev->dev.platform_data is not yet set,
> > leading to a NULL pointer dereference.
> > 
> > Fixes: e4df92279fd9 (USB: host: ohci-at91: merge loops in ohci_hcd_at91_drv_probe)
> 
> Yes, with:
> Cc: stable at vger.kernel.org # 4.3+
> 
> 
> > Reported-by: Peter Rosin <peda@axentia.se>
> > Tested-by: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Alan, I think it's a good candidate to enter the 4.4-rcX...

I agree.  Greg, please merge this with a CC: stable tag added.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

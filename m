From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 21 Jun 2012 11:36:26 -0400 (EDT)
Subject: [PATCH 1/2] ARM: OMAP: USB: Fixup ehci_hcd_omap_probe error path
In-Reply-To: <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <Pine.LNX.4.44L0.1206211136010.1164-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jun 2012, Russ Dill wrote:

> A recent commit, [PATCH] Fix OMAP EHCI suspend/resume failure
> (i693) '354ab856' causes ehci probe to fail on omap3xxx. This
> exposed bugs in the ehci_hcd_omap_probe error path causing
> an oops.
> 
> On the error path, call usb_remove_hcd if usb_add_hcd has been
> called, and call usb_put_hcd if usb_alloc_hcd has been called.
> 
> Tested on BB-xM.
> 
> Signed-off-by: Russ.Dill at ti.com

Acked-by: Alan Stern <stern@rowland.harvard.edu>

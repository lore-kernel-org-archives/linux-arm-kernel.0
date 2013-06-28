From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 28 Jun 2013 13:37:16 -0400 (EDT)
Subject: [PATCH v3 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1372410473-30920-1-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306281336220.1047-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, Ming Lei wrote:

> The patchset supports to run giveback of URB in tasklet context, so that
> DMA unmapping/mapping on transfer buffer and compelte() callback can be
> run with interrupt enabled, then time of HCD interrupt handler(IRQs
> disabled time) can be saved much. Also this approach may simplify HCD
> since HCD lock needn't be released any more before calling
> usb_hcd_giveback_urb().
> 
> The patchset enables the mechanism on EHCI HCD now.

Patches 1, 2, 4 all look okay.  Patch 3 needs a little more work, as 
described in a separate reply.

Alan Stern

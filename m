From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 12:43:52 -0400 (EDT)
Subject: [RFC PATCH v1 4/6] USB: EHCI: don't release ehci->lock if URB
 giveback in tasklet context
In-Reply-To: <1371567833-9077-5-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306181242500.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Ming Lei wrote:

> If HCD_BH is set for HC driver's flags, URB giveback will be
> done in tasklet context instead of interrupt context, so the
> ehci->lock needn't to be released any more before calling
> usb_hcd_giveback_urb().

It is premature to do this now.  This should be part of the 6/6 patch, 
when it won't be necessary to test hcd_giveback_urb_in_bh().

Alan Stern

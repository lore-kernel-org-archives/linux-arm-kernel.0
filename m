From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 Oct 2014 10:11:44 -0400 (EDT)
Subject: [PATCH] usb: ehci/ohci: use SIMPLE_DEV_PM_OPS to support
 hibernation
In-Reply-To: <1414054135-14428-1-git-send-email-wonhong.kwon@lge.com>
Message-ID: <Pine.LNX.4.44L0.1410231009560.1317-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Oct 2014, Wonhong Kwon wrote:

> ehci/ohci just define .suspend/.resume functions for dev_pm_ops, but
> in order to support both STR(suspend-to-ram) and hibernation, other
> callbacks such as .freeze/.thaw are also required.
> 
> Registering all required callbacks for both STR and hibernation can
> be done by SIMPLE_DEV_PM_OPS macro function.
> 
> Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>

The patch itself looks good, but the description and the title should 
be updated.  The patch affects ehci_platform and ohci_platform, not 
ehci and ohci.

If you fix that up, you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

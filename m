From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 13 May 2013 10:13:44 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <1368424303-10629-5-git-send-email-chao.xie@marvell.com>
Message-ID: <Pine.LNX.4.44L0.1305131012090.1389-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 May 2013, Chao Xie wrote:

> Originaly, ehci driver will call the callbacks in platform data
> for PHY initialization and shut down.
> With PHY driver, it will call the APIs provided by PHY driver
> for PHY initialization and shutdown. It removes the callbacks
> in platform data, and at same time it removes one block in the
> way of enabling device tree for ehci driver.

I wonder if this is the sort of thing that should be handled in 
ehci-hcd.c rather than in all the different platform glue drivers.

Felipe, what do you think?  Are the required actions now sufficiently 
generic that a single source file can take care of them?

Alan Stern

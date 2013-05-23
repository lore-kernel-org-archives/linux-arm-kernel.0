From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 19:01:21 +0200
Subject: [RFC V6 PATCH 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1305231034110.925-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305231034110.925-100000@iolanthe.rowland.org>
Message-ID: <201305231901.21632.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Alan Stern wrote:
> On Thu, 23 May 2013, Manjunath Goudar wrote:

> Also, you left out one thing that should still be here.  What happened 
> to the part about changing
> 
> #if	!defined(PCI_DRIVER) &&		\
> 
> to
> 
> #if	!ENABLED(CONFIG_USB_OHCI_HCD_PCI) &&	\
> 

This section of the driver is gone now since 86510bb248 "USB: OHCI: 
clarify Kconfig dependencies", so the change is no longer needed.

	Arnd

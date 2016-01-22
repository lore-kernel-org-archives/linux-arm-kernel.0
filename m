From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 22 Jan 2016 14:29:25 -0500 (EST)
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <2649144.tYaWDcKkag@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1601221426310.1626-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jan 2016, Arnd Bergmann wrote:

> We just have to decide what to do for non-hub devices that the OF
> specification calls "combined nodes" (device class 0, one configuration,
> one interface) and that, like hubs do not have one of_node per interface
> plus one per device, but only one node.
> 
> Should we bind the of_node to the usb_device, the usb_interface or both
> in this case? Doing both might be problematic and would need more
> testing to be sure it works.

The purpose of the of_node would generally be to express requirements 
necessary for operating the device, right?  Since the device has to be 
operational before its interfaces can be known, the of_node should be 
bound to the usb_device.

Alan Stern

From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Aug 2011 14:00:16 -0600 (MDT)
Subject: How to handle named resources with DT?
In-Reply-To: <201108261258.32880.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1108271252100.23968@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2011, Arnd Bergmann wrote:

> I don't think anyone was talking about converting driver /to/ the
> _byname method

For drivers that use multiple resources of the same type, converting those 
to use platform_get_resource_byname() does indeed seem appropriate.

By the way, the same IP block design can exist on platforms with different 
device data formats.  For example, the PowerVR SGX core[1] is present on 
many ARM SoCs and on Intel Poulsbo designs.  The Poulsbo systems are 
presumably using ACPI/SFI *SDT tables.  So it seems unwise to couple 
drivers to any specific external device data format.


- Paul

1. One example: http://en.wikipedia.org/wiki/PowerVR#Series5_.28SGX.29

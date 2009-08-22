From: nico@cam.org (Nicolas Pitre)
Date: Fri, 21 Aug 2009 22:44:00 -0400 (EDT)
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <200908220223.50588.marek.vasut@gmail.com>
References: <200908220223.50588.marek.vasut@gmail.com>
Message-ID: <alpine.LFD.2.00.0908212234150.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 Aug 2009, Marek Vasut wrote:

> Hi,
> 
> This converts most of the drivers found in drivers/mmc/host to dev_pm_ops.
> Also, it contains some fixes for the probe/remove functions in some cases.

Are you sure you're actually fixing things?

You replaced platform_driver_probe() calls with 
platform_driver_register() calls, and made the probe functions __devinit 
instead of __init.  Especially when the platform device is unlikely to 
go away or new ones to ever appear, there is no point keeping the 
probe code around after it is done.


Nicolas

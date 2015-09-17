From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 17 Sep 2015 11:52:02 -0400 (EDT)
Subject: [PATCH v5 01/23] driver core: Add pre_probe callback to bus_type
In-Reply-To: <1442494637-3674-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <Pine.LNX.4.44L0.1509171150410.1270-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015, Tomeu Vizoso wrote:

> Some buses (eg. AMBA) need access to some HW resources (it may need a
> clock to be enabled so a device ID can be read) before a device can be
> matched to a driver.
> 
> The pre_probe callback allows the device-driver core to request the bus
> to perform this initialization and can defer the probe if any of the
> resources needed are missing.
> 
> This gives us more flexibility when setting the order in which devices
> are probed because the resources needed to get the matching information
> don't need to be available by the time that the bus devices are
> registered.

Can't the subsystem do this itself in its matching routine?

Alan Stern

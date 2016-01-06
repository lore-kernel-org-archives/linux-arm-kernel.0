From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 6 Jan 2016 11:20:27 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
References: <CAL411-rK6qfkbQsSjvXH5VPAQAm4tMyD6fVTEgFQrpLHNGMXeA@mail.gmail.com>
 <Pine.LNX.4.44L0.1512181030590.1682-100000@iolanthe.rowland.org>
 <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
 <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
Message-ID: <20160106032027.GA23726@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 08:36:31AM -0600, Rob Herring wrote:
> > 2. There are MFD USB devices, which includes several interfaces under
> > USB device,
> > like i2c, gpios, etc. Due to lack of device tree support, USB
> > class/device driver doesn't know
> > which kinds of interfaces are needed for this board.
> 
> Are you talking about a device hard wired on the same board or
> something like GPIOs on FTDI chip which could be hot-plugged in any
> host (including non-DT based)?

I talked about the case that the device hard wired on the board.
Hot-plug device's bus topology is unknown, we can't describe it
statically at dts.

> 
> For the hotplug case, we will need a way to associate a DT overlay
> with the USB device and there may not even be a base DT to map the
> overlay into. In this case, the USB device's driver will need to load
> the overlay and trigger enumerating the child devices. Anyway, this is
> a separate issue from your problem.
> 

Since both you and Alan agree with my problem should be fixed at
bootloader, I give the kernel solution up. 

The another thing I open to discuss is how to let USB devices know its
device node, the user reported issue that they can't handle interfaces
below in USB device since that.

-- 

Best Regards,
Peter Chen

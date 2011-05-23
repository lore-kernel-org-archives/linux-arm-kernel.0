From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 May 2011 17:30:06 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <B876E8072D52496DB747D5CCCF64826D@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105151133.23870.arnd@arndb.de>
	<B876E8072D52496DB747D5CCCF64826D@subhasishg>
Message-ID: <201105231730.06564.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 May 2011, Subhasish Ghosh wrote:
> I earlier had an implementation where I used a pruss_devices structure
> in the board file.
> 
> http://linux.omap.com/pipermail/davinci-linux-open-source/
> 2011-March/022339.html.
> 
> We can use this implementation along with the sysfs to load the devices
> runtime. 

Possibly, but the actual data structures might end up differently
when they are built around a sysfs interface. If you have a sysfs
interface, it is more important to have that in a clean way than
the board file, so we should first discuss the set of sysfs
attributes that you are going to need, and then see how to
represent that in platform data for predefined boards.

> The configs that I have in the board_file for the devices 
> structure, are fixed for a board. To swap the boards, we do not need to re-compile
> the kernel.

The other point to consider is that we are definitely moving
towards the flattened device tree for these definitions now.
It's probably good to make the sysfs attributes directly correspond
to fdt device properties. I'm not sure if we also need to allow platform
data. The easiest way could be to just require the use of device tree
for predefined pruss devices.

I'm sorry that this is moving in a different direction now, you
had an unfortunate timing here.

Let's first discuss the exact properties that are really required
to define the differences between PRU backends, as those will
be required in any case. What do you need for PRU specific
data besides the firmware and the name of the device?

	Arnd

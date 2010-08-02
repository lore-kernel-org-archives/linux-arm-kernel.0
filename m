From: gregkh@suse.de (Greg KH)
Date: Mon, 2 Aug 2010 15:47:18 -0700
Subject: [PATCH] USB-serial dummy cable driver
In-Reply-To: <1280728807-20296-1-git-send-email-marek.vasut@gmail.com>
References: <1280728807-20296-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100802224718.GC28821@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 08:00:07AM +0200, Marek Vasut wrote:
> This driver is used to implement USB-serial like behaviour over dummy
> USB cables. These are used in the following devices:
> 	Funsoft Serial USB driver
> 	Genesys Logic GL620USB USB Laplink cable
> 	HP4x (48/49) Serial cable
> 	Motorola phones
> 	Siemens USB-MPI Serial USB driver
> 	ViVOpay USB Serial Driver
> 	ZIO Motherboard USB driver

I like the idea, but not the name :)

Ideally, all of these would be able to be handled by the usb-serial
generic driver directly.

But really, having these multiple drivers is a good thing, they properly
convey to the user what the device is, and it gives these developers and
companies a sense of ownership over the code, and that matters at times.

So you lost the names of the devices with this patch, which isn't good.

It's my end-goal to move the usb-serial layer to be more like libata,
where it is dirt-simple to make a new disk driver, only a few fields to
fill in, what you want to override.  So, any work toward simplification
of the generic layer would be appreciated to make these individual
drivers even smaller in the end.

So don't delete them, but try to consolidate the code, or just make it
so that it can be deleted, and you only need a simple module init/exit
function that registeres a single structure, like libata.

Sound reasonable?

thanks,

greg k-h

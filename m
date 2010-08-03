From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 3 Aug 2010 18:14:15 +0200
Subject: [PATCH] USB-serial dummy cable driver
In-Reply-To: <20100802224718.GC28821@suse.de>
References: <1280728807-20296-1-git-send-email-marek.vasut@gmail.com>
	<20100802224718.GC28821@suse.de>
Message-ID: <201008031814.15859.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 3. srpna 2010 00:47:18 Greg KH napsal(a):
> On Mon, Aug 02, 2010 at 08:00:07AM +0200, Marek Vasut wrote:
> > This driver is used to implement USB-serial like behaviour over dummy
> > 
> > USB cables. These are used in the following devices:
> > 	Funsoft Serial USB driver
> > 	Genesys Logic GL620USB USB Laplink cable
> > 	HP4x (48/49) Serial cable
> > 	Motorola phones
> > 	Siemens USB-MPI Serial USB driver
> > 	ViVOpay USB Serial Driver
> > 	ZIO Motherboard USB driver
> 
> I like the idea, but not the name :)

Please don't expect miracles from me after 26 hours without sleep ;-)
> 
> Ideally, all of these would be able to be handled by the usb-serial
> generic driver directly.

I just noticed that one. Stupid me.
> 
> But really, having these multiple drivers is a good thing, they properly
> convey to the user what the device is, and it gives these developers and
> companies a sense of ownership over the code, and that matters at times.
> 
> So you lost the names of the devices with this patch, which isn't good.

Sheesh ... that's true, but having pile of copies of the same code is not good 
either. Can't we then just deprecate all these drivers and set correct udev 
rules?
> 
> It's my end-goal to move the usb-serial layer to be more like libata,
> where it is dirt-simple to make a new disk driver, only a few fields to
> fill in, what you want to override.  So, any work toward simplification
> of the generic layer would be appreciated to make these individual
> drivers even smaller in the end.
> 
> So don't delete them, but try to consolidate the code, or just make it
> so that it can be deleted, and you only need a simple module init/exit
> function that registeres a single structure, like libata.
> 
> Sound reasonable?

Sounds ok, I'd like to help you but I'm dead busy with a pile of ARM machines 
here. This hack was really just a side-job. I'll try looking into it if I wont 
get insane ;-)

Cheers
> 
> thanks,
> 
> greg k-h

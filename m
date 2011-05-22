From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 22 May 2011 22:21:31 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105112203.54838.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105102344.58598.arnd@arndb.de>
	<82D549BB195345A1A189D569952B387C@subhasishg>
	<201105112203.54838.arnd@arndb.de>
Message-ID: <20110522202129.GE18610@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, May 11, 2011 at 10:03:54PM +0200, Arnd Bergmann wrote:
> On Wednesday 11 May 2011, Subhasish Ghosh wrote:
> > > Please look into implementing one of the three I suggested before
> > > you go off in another direction. In case of the third one, the idea
> > > was to configure the name of the device for each pru using sysfs,
> > > which then gets bound to the driver, which loads its own firmware
> > > as you do today. Only in the first two suggestions, the mfd driver
> > > would be responsible for loading the firmware.
> > 
> > Ok, thanks for the clarification.
> > Instead of passing the device name, will it be ok to pass the mfd_id.
> > The benefit will be that I can use the ID directly as an array
> > index for the mfd_cell entries.
> 
> I think a device name would be clearer here, especially in order
> to avoid conflicts when the list gets extended in different ways
> depending on which kernel runs.
> 
> We had a little discussion at the Linaro Developer Summit about your
> driver and mfd drivers in general. There was a general feeling among
> some people (including me) that by the point you dynamically create
> the subdevices, MFD is probably not the right abstraction any more,
> as it does not provide any service that you need.
I agree it's not what it's been designed for.


> Instead, maybe you can simply call platform_device_register
> at that stage to create the children and not use MFD at all.
The MFD APIs are slightly easier to use though, imho.


> Samuel, can you comment on this as well? Do you still see pruss
> as an MFD driver when the uses are completely dynamic and determined
> by the firmware loaded into it?
Even though that is definitely not a typical MFD use case, I wouldn't object
strongly against it. Right now mfd is probably the least worst choice for this
kind of drivers, which still doesn't make it an ideal situation.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

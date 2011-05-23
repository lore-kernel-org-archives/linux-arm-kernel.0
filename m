From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 May 2011 17:13:48 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <20110522202129.GE18610@sortiz-mobl>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105112203.54838.arnd@arndb.de>
	<20110522202129.GE18610@sortiz-mobl>
Message-ID: <201105231713.49067.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Sunday 22 May 2011, Samuel Ortiz wrote:
> On Wed, May 11, 2011 at 10:03:54PM +0200, Arnd Bergmann wrote:
> > On Wednesday 11 May 2011, Subhasish Ghosh wrote:
> > We had a little discussion at the Linaro Developer Summit about your
> > driver and mfd drivers in general. There was a general feeling among
> > some people (including me) that by the point you dynamically create
> > the subdevices, MFD is probably not the right abstraction any more,
> > as it does not provide any service that you need.
> I agree it's not what it's been designed for.
> 
> 
> > Instead, maybe you can simply call platform_device_register
> > at that stage to create the children and not use MFD at all.
> The MFD APIs are slightly easier to use though, imho.
> 
> 
> > Samuel, can you comment on this as well? Do you still see pruss
> > as an MFD driver when the uses are completely dynamic and determined
> > by the firmware loaded into it?
> Even though that is definitely not a typical MFD use case, I wouldn't object
> strongly against it. Right now mfd is probably the least worst choice for this
> kind of drivers, which still doesn't make it an ideal situation.

Thanks for your input! When you say that MFD APIs are easier to use than
platform_device APIs, is that something we should fix with platform devices
to make them easier to use?

	Arnd

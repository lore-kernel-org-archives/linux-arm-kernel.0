From: greg@kroah.com (Greg KH)
Date: Tue, 24 May 2011 06:43:38 -0700
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <201105241440.34854.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105231730.06564.arnd@arndb.de>
	<7E10264BABCB4C1788DCD9715461BDE8@subhasishg>
	<201105241440.34854.arnd@arndb.de>
Message-ID: <20110524134338.GA13491@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 02:40:34PM +0200, Arnd Bergmann wrote:
> On Tuesday 24 May 2011, Subhasish Ghosh wrote:
> > Would it be a good approach to first get a basic sensible
> > driver into the tree and then work towards improving and
> > adjusting for future compatibilities.
> 
> The main problem with that is that you cannot really change
> user-visible interfaces after the driver is merged. Anything
> regarding sysfs attributes and firmware file contents needs
> to be fixed. You can however still change in-kernel interfaces
> at a later point without problems.
> 
> > That way we can gradually build towards the perfect driver
> > in steps, rather than digressing far too off suddenly.
> > That would be some source of motivation for me too.
> 
> You can definitely add the driver to drivers/staging/pruss/,
> as the rules for staging drivers are different. I think that
> would indeed be helpful at this point. As soon as all
> interfaces have stabilized, you can then move the individual
> parts to their final location.
> 
> Greg maintains the staging drivers, and he can surely point
> you to a document describing what is required for a driver.

There really are only 3 rules:
	- proper license
	- self-contained in a drivers/staging/DRIVER_NAME/ directory
	- must properly build

> Mainly, this includes having a patch that adds a single
> directory with all the driver files under drivers/staging.
> The driver must be able to compile without errors and you need
> a TODO file listing the remaining issues that prevent you
> from having a non-staging driver.

Ah, forgot the TODO on the list of rules, I'll have to add that next
time.

Someone feel free to send me a patch :)

thanks,

greg k-h

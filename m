From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2011 14:40:34 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver
In-Reply-To: <7E10264BABCB4C1788DCD9715461BDE8@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105231730.06564.arnd@arndb.de>
	<7E10264BABCB4C1788DCD9715461BDE8@subhasishg>
Message-ID: <201105241440.34854.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 May 2011, Subhasish Ghosh wrote:
> Would it be a good approach to first get a basic sensible
> driver into the tree and then work towards improving and
> adjusting for future compatibilities.

The main problem with that is that you cannot really change
user-visible interfaces after the driver is merged. Anything
regarding sysfs attributes and firmware file contents needs
to be fixed. You can however still change in-kernel interfaces
at a later point without problems.

> That way we can gradually build towards the perfect driver
> in steps, rather than digressing far too off suddenly.
> That would be some source of motivation for me too.

You can definitely add the driver to drivers/staging/pruss/,
as the rules for staging drivers are different. I think that
would indeed be helpful at this point. As soon as all
interfaces have stabilized, you can then move the individual
parts to their final location.

Greg maintains the staging drivers, and he can surely point
you to a document describing what is required for a driver.
Mainly, this includes having a patch that adds a single
directory with all the driver files under drivers/staging.
The driver must be able to compile without errors and you need
a TODO file listing the remaining issues that prevent you
from having a non-staging driver.

I think the list will be relatively short, given that you
have made a lot of progress and the driver is now essentially
ready, aside from a few details and the big question of
how the firmware should be configured and loaded.

	Arnd

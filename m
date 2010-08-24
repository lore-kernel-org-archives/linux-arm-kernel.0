From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Aug 2010 17:26:08 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100824150655.GB2160@osiris.boeblingen.de.ibm.com>
References: <4C61EE55.5030506@codeaurora.org>
	<201008191309.15425.arnd@arndb.de>
	<20100824150655.GB2160@osiris.boeblingen.de.ibm.com>
Message-ID: <201008241726.08797.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 August 2010, Heiko Carstens wrote:
> > (Taking Martin and Heiko on Cc for s390)
> > 
> > I'd strongly suggest making the behavior the same for everyone. It should
> > be fairly easy to make sure none of these warnings ever triggers
> > on s390, because most of the Linux device driver code does not get build
> > there anyway.
> 
> Please don't do that. An s390 allyesconfig still triggers 45 warnings and
> I'm currently not willing to "patch" working code just to get rid of these
> warnings which are most likely all false positives.
> That's the reason why we currently don't error out and only generate
> warnings.

Can't you just turn that option off then? Or are you worried about
allyesconfig builds?

The current state is confusing because on s390
CONFIG_DEBUG_STRICT_USER_COPY_CHECKS means that gcc will warn rather
than ignore the finding, while on all others, the same option turns
a warning into an error.

Test-building an allmodconfig on s390 showed these warnings only in
architecture independent code, and I agree that they are all false
positives.

	Arnd

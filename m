From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Aug 2010 15:55:53 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100825125451.GH2153@osiris.boeblingen.de.ibm.com>
References: <4C61EE55.5030506@codeaurora.org>
	<201008251414.16411.arnd@arndb.de>
	<20100825125451.GH2153@osiris.boeblingen.de.ibm.com>
Message-ID: <201008251555.53653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 August 2010, Heiko Carstens wrote:
> 
> On Wed, Aug 25, 2010 at 02:14:16PM +0200, Arnd Bergmann wrote:
> > > Then maybe add a "choice" Kconfig option in a way that both allyesconfig
> > > as well as allnoconfig will build?
> > 
> > I think it would be easier to remove the config option entirely on s390
> > and just always warn. As I said earlier in this thread, I generally
> > don't think this particular warning is more important than a lot of
> > the other ones that we don't turn into errors.
> 
> I disagree: a default kernel build should compile without the noise of
> tens of false positive warnings.
> Nobody would look at new warnings and fix possible bugs.
> That's why I want to have an option to turn the warnings off (default).
> 
> Or are you volunteering to "fix" all the false positives? :)

If you don't want to see the warnings, then just remove the strict checks.
We already concluded that there is little value in them on s390 since it only
shows false postives.

Maybe the easiest way would be to rename the option on s390 and move all
the other ones into a common place.

	Arnd

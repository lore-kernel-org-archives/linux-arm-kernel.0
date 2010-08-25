From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Aug 2010 14:14:16 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <20100824154740.GD2160@osiris.boeblingen.de.ibm.com>
References: <4C61EE55.5030506@codeaurora.org>
	<201008241726.08797.arnd@arndb.de>
	<20100824154740.GD2160@osiris.boeblingen.de.ibm.com>
Message-ID: <201008251414.16411.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 August 2010, Heiko Carstens wrote:
> On Tue, Aug 24, 2010 at 05:26:08PM +0200, Arnd Bergmann wrote:
> > Can't you just turn that option off then? Or are you worried about
> > allyesconfig builds?
> 
> I'd like to keep an allyesconfig compiling and booting.
> With the proposed change we would never see a green entry at
> http://kisskb.ellerman.id.au/kisskb/branch/9/ for s390's allyesconfig
> build ;)

Yes, that makes sense.

> Then maybe add a "choice" Kconfig option in a way that both allyesconfig
> as well as allnoconfig will build?

I think it would be easier to remove the config option entirely on s390
and just always warn. As I said earlier in this thread, I generally
don't think this particular warning is more important than a lot of
the other ones that we don't turn into errors.

I do think it would be helpful to optionally build parts of the kernel
with the much stronger '-Werror', which we already do for some
architectures. You could do that with inverted logic (bool "Disable -Werror
compile option) and fix all warnings in allnoconfig to make all of
allnoconfig, allyesconfig and defconfig build.

	Arnd

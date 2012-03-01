From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:12:00 +0000
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <20120301193643.GA607@kroah.com>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
 <20120301193643.GA607@kroah.com>
Message-ID: <201203012012.01266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Greg Kroah-Hartman wrote:
> On Thu, Mar 01, 2012 at 02:26:50PM -0500, Alan Ott wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The driver should not call set_irq_flags itself, and
> > cannot do this from a loadable module.
> > 
> > Remove the call for now, which might break the driver
> > but at least lets the kernel link again.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Um, I think you should test this out before submitting it anywhere :)
> 
> As it is, I can't accept it.

Right, this one was not meant for inclusion, similar to patch 5 in this
series.

Alan:
Part of the reason I asked for help getting the patches out is that
they need a lot of auditing, both for whether they still apply to
current kernels and for whether they are a good solution to the problem
at hand. When in doubt, it's probably better to leave out any patch
that looks like it might not be ready for inclusion, or that might
make thinks uglier in some way.

	Arnd

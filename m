From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 15:45:17 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <20130316000936.GB10166@kroah.com>
References: <201303151700.27231.arnd@arndb.de>
 <201303152113.52258.arnd@arndb.de> <20130316000936.GB10166@kroah.com>
Message-ID: <201303181545.18083.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 March 2013, Greg Kroah-Hartman wrote:
> On Fri, Mar 15, 2013 at 09:13:52PM +0000, Arnd Bergmann wrote:
> > On Friday 15 March 2013, Greg Kroah-Hartman wrote:
> > > > Unless something is changed, this patch won't get into 3.9-final.  
> > > > Do you want Greg to move it to his usb-linus branch?
> > > 
> > > It's a bit too "big" for 3.9-final, sorry.
> > 
> > Would you consider the hot fix at the start of this thread for 3.9
> > then? I can resubmit it as a patch for inclusion with the missing
> > hunk added in if there are no objections.
> 
> Feel free to resend, but remember, I am very leery of pushing this
> type of patch in at the moment, given my past history with it...

Sure, it's your decision. I just don't want to be accused of abandoning the
issue that I caused. It's not strictly a regression because no configuration
that was working in 3.8 is broken in 3.9, and embedded systems won't normally
run a multiplatform kernel anyway. Also, the patch is really an ugly hack,
which is probably enough reason not to take it. ;-)

The only situation I can think of that is broken without the hotfix is
distribution kernels that were already running multiplatform on Armada XP
(mvebu/orion) and now want to add OMAP support without breaking the
platforms that are already working. Peter Robinson is doing this on for
Fedora right now[1] and I assume the Debian/Ubuntu/OpenSUSE/Gentoo
people will be in a similar situation, but they can all apply the patch
manually if it doesn't make it into 3.9. It won't be the only patch they
need to get there, it's just the only one for 3.9 we already know about.

	Arnd

[1] https://plus.google.com/117898952501074015902/posts/VgnDhJBxbU4

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 17:32:18 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <878v5kd503.fsf@lebrac.rtp-net.org>
References: <201303151700.27231.arnd@arndb.de>
 <201303181545.18083.arnd@arndb.de> <878v5kd503.fsf@lebrac.rtp-net.org>
Message-ID: <201303181732.18438.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Arnaud Patard wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

> > Sure, it's your decision. I just don't want to be accused of abandoning the
> > issue that I caused. It's not strictly a regression because no configuration
> > that was working in 3.8 is broken in 3.9, and embedded systems won't normally
> > run a multiplatform kernel anyway. Also, the patch is really an ugly hack,
> > which is probably enough reason not to take it. ;-)
> 
> Given that the omap patch has been accepted and that the patch is an
> "ugly hack", how hard it would be to provide a working patch for mvebu
> (well, orion usb driver) ?

The OMAP patch was accepted for 3.10, and I'm sure we will have good
patches for the other bus glues as well, but the bug is also present on
3.9, and the proper patches are too invasive now to get merged there.

> > platforms that are already working. Peter Robinson is doing this on for
> > Fedora right now[1] and I assume the Debian/Ubuntu/OpenSUSE/Gentoo
> > people will be in a similar situation, but they can all apply the
> > patch
> 
> fwiw, I've mentionned this usb issue few days ago when talking about
> multiplatform on the debian-arm ml.

Yes, we've known about it for a long time, but failed to get the proper
patches out in time :(

> > manually if it doesn't make it into 3.9. It won't be the only patch they
> 
> it can applied in the debian kernel, as long as the patch is merged
> upstream.

It won't be merged in 3.10, but in that case Debian can backport the proper
patches from 3.10.

	Arnd

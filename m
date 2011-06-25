From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 25 Jun 2011 08:02:20 -0400 (EDT)
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <4E05A9B1.5090000@free.fr>
Message-ID: <Pine.LNX.4.44L0.1106250758250.1039-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Jun 2011, Robert Jarzmik wrote:

> On 06/22/2011 05:19 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Jun 22, 2011 at 11:02:27AM -0400, Alan Stern wrote:
> >> No, the patch is appropriate.
> Indeed.
> >>
> >> We don't need better communication.  If g_mass_storage (for example)
> >> knows that the device is in use, it can block suspends by returning
> >> -EBUSY from its own suspend callback.  The UDC driver doesn't need to
> >> worry about these matters; it should assume that such things have
> >> already been handled elsewhere.  That's what Dmitry meant when he was
> >> talking about a "higher level driver" -- maybe "lower level" would have
> >> been a better choice of words.  :-)
> The suspend at driver level should not care about filesystem in use, etc 
> ... A disconnected cable cannot be prevented by the kernel, and the 
> effect in fine is the same as the suspend.

This is a little ironic, because the mass-storage gadget driver has no
idea whether a filesystem is in use or not.  All it knows is whether it
is currently connected to a host.  Besides, it's questionable whether
the gadget driver should prevent the gadget from suspending.  This is a
policy matter which must be decided by the user, not by the kernel.

Nevertheless...  The fact that the kernel can do nothing about a
disconnected cable shouldn't stop us from handling system sleep
correctly.  After all, the kernel _can_ do something about that.

Alan Stern

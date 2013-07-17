From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 17 Jul 2013 12:17:24 -0400 (EDT)
Subject: [PATCH v3 6/7] USB: ohci-at91: add usb_clk for transition to
 common clk framework
In-Reply-To: <51E6BC23.6020700@overkiz.com>
Message-ID: <Pine.LNX.4.44L0.1307171215000.1555-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jul 2013, boris brezillon wrote:

> On 17/07/2013 17:33, Alan Stern wrote:
> > On Tue, 16 Jul 2013, Boris BREZILLON wrote:
> >
> >> The AT91 PMC (Power Management Controller) provides an USB clock used by
> >> USB Full Speed host (ohci) and USB Full Speed device (udc).
> >> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
> >> This configuration was formely done in mach-at91/clock.c, but this
> >> implementation will be removed when moving to common clk framework.
> >>
> >> This patch add support for usb clock retrieval and configuration, and is
> >> backward compatible with the current at91 clk implementation (if usb clk
> >> is not found, it does not configure/enable the usb clk).
> > This does not take into account any of the changes you discussed with
> > Russell King and me -- it is exactly the same as the previous version.
> Sorry, I don't understand. I didn't send any new version since yesterday.

Oh.  Never mind.  That message was the _same_ one that I replied to
yesterday.  I got two copies of it, because you sent it both to me
directly and to linux-usb.  For some reason one of the copies was
delayed for many hours, so I thought it was a new message.

Alan Stern

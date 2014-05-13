From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 May 2014 14:52:55 -0500
Subject: [PATCH 6/8] usb: xhci: avoid warning for !PM_SLEEP
In-Reply-To: <7882044.S9pqnTAVYy@wuerfel>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-7-git-send-email-arnd@arndb.de>
 <20140513152829.GK1151@saruman.home> <7882044.S9pqnTAVYy@wuerfel>
Message-ID: <20140513195255.GC1151@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:39:37PM +0200, Arnd Bergmann wrote:
> On Tuesday 13 May 2014 10:28:29 Felipe Balbi wrote:
> > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > index 151901c..3473296 100644
> > > --- a/drivers/usb/host/xhci-plat.c
> > > +++ b/drivers/usb/host/xhci-plat.c
> > > @@ -202,7 +202,7 @@ static int xhci_plat_remove(struct platform_device *dev)
> > >       return 0;
> > >  }
> > >  
> > > -#ifdef CONFIG_PM
> > > +#ifdef CONFIG_PM_SLEEP
> > 
> > can we just drop the ifdeferry altogether, including from SET_*_OPS
> > macros ? This is just ridiculous that every merge window we have tens of
> > patches fixing the ifdef in several drivers.
> 
> That would work for me. Another suggestion that came up before was
> to change the SET_*_OPS so that the compiler silently drops the unused
> functions, but unfortunately that would require changing all drivers.

either way would work for me, and such patches would probably be merged
through the trivial tree.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/fc4f2ed9/attachment.sig>

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 May 2014 21:39:37 +0200
Subject: [PATCH 6/8] usb: xhci: avoid warning for !PM_SLEEP
In-Reply-To: <20140513152829.GK1151@saruman.home>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-7-git-send-email-arnd@arndb.de>
 <20140513152829.GK1151@saruman.home>
Message-ID: <7882044.S9pqnTAVYy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 10:28:29 Felipe Balbi wrote:
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 151901c..3473296 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -202,7 +202,7 @@ static int xhci_plat_remove(struct platform_device *dev)
> >       return 0;
> >  }
> >  
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> 
> can we just drop the ifdeferry altogether, including from SET_*_OPS
> macros ? This is just ridiculous that every merge window we have tens of
> patches fixing the ifdef in several drivers.

That would work for me. Another suggestion that came up before was
to change the SET_*_OPS so that the compiler silently drops the unused
functions, but unfortunately that would require changing all drivers.

	Arnd

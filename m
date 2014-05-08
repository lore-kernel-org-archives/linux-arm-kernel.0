From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 May 2014 16:27:12 +0200
Subject: [PATCH 5/8] usb: phy: msm: reset controller is mandatory now
In-Reply-To: <1399558909.8165.8.camel@iivanov-dev>
References: <1399557141-1346645-1-git-send-email-arnd@arndb.de>
 <1399557141-1346645-6-git-send-email-arnd@arndb.de>
 <1399558909.8165.8.camel@iivanov-dev>
Message-ID: <63604204.8DeBUXOvCl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 May 2014 17:21:49 Ivan T. Ivanov wrote:
> > @@ -168,7 +168,7 @@ config USB_EHCI_HCD_AT91
> >  
> >  config USB_EHCI_MSM
> >       tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
> > -     depends on ARCH_MSM
> > +     depends on ARCH_MSM && RESET_CONTROLLER
> 
> This driver did not use reset controller API.
> 
> >       select USB_EHCI_ROOT_HUB_TT
> >       select USB_MSM_OTG

It does select USB_MSM_OTG though, which uses it:

Maybe that 'select' is wrong?

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 23:12:59 +0200
Subject: [PATCH 18/21] USB: ehci-msm: USB_MSM_OTG needs USB_PHY
In-Reply-To: <20130425175950.GA14654@kroah.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-19-git-send-email-arnd@arndb.de>
 <20130425175950.GA14654@kroah.com>
Message-ID: <201304252312.59822.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 April 2013, Greg Kroah-Hartman wrote:
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index c558472..de94f26 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -188,6 +188,7 @@ config USB_EHCI_HCD_AT91
> >  config USB_EHCI_MSM
> >       tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
> >       depends on ARCH_MSM
> > +     depends on USB_PHY
> >       select USB_EHCI_ROOT_HUB_TT
> >       select USB_MSM_OTG
> >       ---help---
> 
> But this does, and I'm guessing that it's the more important part, so
> I'll just edit it and only take this hunk, ok?

Ok, thanks! Sorry for bothering you with the hand editing. I'll apply
the defconfig change to arm-soc then.

	Arnd

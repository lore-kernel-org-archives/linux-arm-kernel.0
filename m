From: greg@kroah.com (Greg KH)
Date: Tue, 23 Jul 2013 16:06:14 -0700
Subject: [PATCH V4 00/11]  USB: OHCI:Properly handle
 ohci_suspend()routine in bus glue
In-Reply-To: <51ED00A3.8080004@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1374485566-3997-1-git-send-email-manjunath.goudar@linaro.org>
 <51ED00A3.8080004@linaro.org>
Message-ID: <20130723230614.GA13083@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 03:21:31PM +0530, manjunath wrote:
> On Monday 22 July 2013 03:02 PM, Manjunath Goudar wrote:
> >Suspend scenario in case of ohci bus glue was not properly handled as
> >it was not suspending generic part of ohci controller. Calling
> >explicitly the ohci_suspend()routine will ensure proper handling
> >of suspend scenario.
> >
> >V2:
> >  -Incase ohci_suspend() fails, return right away without executing further.
> >
> >V3:
> >  -New patch 1/11 added, for generic ohci-hcd suspend code.
> >
> >V4:
> >  -Properly aligned "do_wakeup" and "ret" variables.
> >
> >Manjunath Goudar (11):
> >   USB: OHCI: Properly handle OHCI controller suspend
> >   USB: OHCI: Properly handle ohci-at91 suspend
> >   USB: OHCI: Properly handle ohci-s3c2410 suspend
> >   USB: OHCI: Properly handle ohci-da8xx suspend
> >   USB: OHCI: Properly handle ohci-ep93xx suspend
> >   USB: OHCI: Properly handle ohci-exynos suspend
> >   USB: OHCI: Properly handle ohci-omap suspend
> >   USB: OHCI: Properly handle ohci-platform suspend
> >   USB: OHCI: Properly handle ohci-pxa27x suspend
> >   USB: OHCI: Properly handle ohci-sm501 suspend
> >   USB: OHCI: Properly handle ohci-spear suspend
> >
> >  drivers/usb/host/ohci-at91.c     |   10 ++++++++--
> >  drivers/usb/host/ohci-da8xx.c    |   15 +++++++++++----
> >  drivers/usb/host/ohci-ep93xx.c   |    9 ++++++++-
> >  drivers/usb/host/ohci-exynos.c   |   20 +++++---------------
> >  drivers/usb/host/ohci-hcd.c      |    9 ++++++++-
> >  drivers/usb/host/ohci-omap.c     |   13 ++++++++++---
> >  drivers/usb/host/ohci-platform.c |    9 ++++++++-
> >  drivers/usb/host/ohci-pxa27x.c   |    8 +++++++-
> >  drivers/usb/host/ohci-s3c2410.c  |   19 ++++---------------
> >  drivers/usb/host/ohci-sm501.c    |   11 +++++++++--
> >  drivers/usb/host/ohci-spear.c    |   12 +++++++++---
> >  11 files changed, 87 insertions(+), 48 deletions(-)
> >
> I am sorry, not updated patch subject line. This is patch V4 series.

I'm totally confused by all of the different series of patches you've
sent out, and I don't see Arnd's acks on any of them, so I'll just purge
them all from my queue and wait for the next round.

Also, after what happened last time, I require Arnd to sign-off on all
of these types of patches, if for no other reason than I want someone I
know to be around when they break things :)

thanks,

greg k-h

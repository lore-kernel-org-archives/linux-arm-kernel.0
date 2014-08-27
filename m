From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 27 Aug 2014 09:28:29 +0200
Subject: [PATCH 2/2 v2] ARM: exynos_defconfig: enable USB gadget support
In-Reply-To: <53FD36AD.1020509@suse.de>
References: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1409038230-7242-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <53FD36AD.1020509@suse.de>
Message-ID: <1409124509.31096.42.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-08-27 at 03:38 +0200, Andreas F?rber wrote:
> Am 26.08.2014 09:30, schrieb Sjoerd Simons:
> > Enable USB gadget support without support for any specific gadgets to
> > more easily catch cases where a devices dts doesn't specify the usb
> > controllers dr_mode while it should.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> >  Changes in v2: none
> > 
> >  arch/arm/configs/exynos_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> > index fc7d168..3664120 100644
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@ -54,6 +54,7 @@ CONFIG_SMSC911X=y
> >  CONFIG_USB_USBNET=y
> >  CONFIG_USB_NET_SMSC75XX=y
> >  CONFIG_USB_NET_SMSC95XX=y
> > +CONFIG_USB_GADGET=y
> 
> Do we also need CONFIG_USB_DWC3_DUAL_ROLE=y? The default seemed to be
> CONFIG_USB_DWC3_HOST.

Nope that gets set by this Kconfig snippet:

choice
   bool "DWC3 Mode Selection"
   default USB_DWC3_DUAL_ROLE if (USB && USB_GADGET)
   default USB_DWC3_HOST if (USB && !USB_GADGET)
   default USB_DWC3_GADGET if (!USB && USB_GADGET)

Iotw by both enable USB and USB_GADGET the default will switch form
CONFIG_USB_DWC3_HOST to CONFIG_USB_DWC3_DUAL_ROLE=y

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/ecf9bbfd/attachment.bin>

From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Sep 2014 09:37:11 -0500
Subject: [PATCH 5/5] phy: exynos5-usbdrd: Adding Kconfig dependency for
 Exynos7
In-Reply-To: <CAFp+6iHsfg6Ru0LBN=JviV=-mSdmuSo9Te3EXYF+X8jssD_BYQ@mail.gmail.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-6-git-send-email-gautam.vivek@samsung.com>
 <CAN_we7MQAqEsRaQc_pkRE_KXx9zZNLDBR2aHUrazM30Nv3udmQ@mail.gmail.com>
 <CAFp+6iHsfg6Ru0LBN=JviV=-mSdmuSo9Te3EXYF+X8jssD_BYQ@mail.gmail.com>
Message-ID: <20140902143711.GD16872@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 01:30:21PM +0530, Vivek Gautam wrote:
> On Thu, Aug 28, 2014 at 8:36 PM, Daniele Forsi <dforsi@gmail.com> wrote:
> > 2014-08-28 10:02 GMT+02:00 Vivek Gautam:
> >
> >> This USB 3.0 PHY controller is also present on Exynos7
> >> platform, so adding the dependency on ARCH_EXYNOS7 for this driver.
> >
> >> +++ b/drivers/phy/Kconfig
> >> @@ -186,7 +186,7 @@ config PHY_EXYNOS5250_USB2
> >>
> >>  config PHY_EXYNOS5_USBDRD
> >>         tristate "Exynos5 SoC series USB DRD PHY driver"
> >> -       depends on ARCH_EXYNOS5 && OF
> >> +       depends on (ARCH_EXYNOS5 || ARCH_EXYNOS7) && OF
> >
> > shouldn't that prompt and its help text be updated to mention also Exynos7?
> 
> Right, even that has to be updated accordingly. Will update the same in next
> version of the patch. Thanks for pointing this.

I would rather change that to ARCH_EXYNOS, unless Kishon doesn't like
that idea. The thing is that this will likely need to be patches for
exynos8, 9, 10, 11...

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/26413d4c/attachment.sig>

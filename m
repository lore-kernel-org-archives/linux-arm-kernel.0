From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 21 Jun 2016 15:19:12 +0200
Subject: [PATCH] drm: mediatek: remove IOMMU_DMA select
In-Reply-To: <3436915.Zo8cThvXaA@wuerfel>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
 <1462997501-982363-1-git-send-email-arnd@arndb.de>
 <3436915.Zo8cThvXaA@wuerfel>
Message-ID: <20160621131912.GA6060@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 10:15:20PM +0200, Arnd Bergmann wrote:
> On Wednesday 11 May 2016 22:11:07 Arnd Bergmann wrote:
> > We get a harmless build warning when trying to use the mediatek
> > DRM driver with IOMMU support disabled:
> > 
> > warning: (DRM_MEDIATEK) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT)
> > 
> > However, the IOMMU_DMA symbol is not meant to be used by drivers
> > at all, and this driver doesn't seem to have a strict dependency
> > on it other than using the mediatek IOMMU driver that does.
> > 
> > Since we also want to be able to do compile tests with the
> > driver on other platforms, the IOMMU_DMA symbol should not
> > be selected here.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > If someone has a better explanation about why the 'select' is here,
> > let me know, it certainly seems out of place.
> 
> Sorry, I didn't mean to send this as a reply to "More build fixes for
> omapdrm in current -next", I copied the wrong command line.
> 
> I'll resend it if necessary.

That's probably the reason why patchwork didn't include the commit
message in the downloaded mbox. I've pieced it together manually and
applied this to topic/drm-misc.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/563249f9/attachment.sig>

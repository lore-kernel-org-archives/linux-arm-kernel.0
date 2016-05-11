From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 22:15:20 +0200
Subject: [PATCH] drm: mediatek: remove IOMMU_DMA select
In-Reply-To: <1462997501-982363-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
 <1462997501-982363-1-git-send-email-arnd@arndb.de>
Message-ID: <3436915.Zo8cThvXaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2016 22:11:07 Arnd Bergmann wrote:
> We get a harmless build warning when trying to use the mediatek
> DRM driver with IOMMU support disabled:
> 
> warning: (DRM_MEDIATEK) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT)
> 
> However, the IOMMU_DMA symbol is not meant to be used by drivers
> at all, and this driver doesn't seem to have a strict dependency
> on it other than using the mediatek IOMMU driver that does.
> 
> Since we also want to be able to do compile tests with the
> driver on other platforms, the IOMMU_DMA symbol should not
> be selected here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If someone has a better explanation about why the 'select' is here,
> let me know, it certainly seems out of place.

Sorry, I didn't mean to send this as a reply to "More build fixes for
omapdrm in current -next", I copied the wrong command line.

I'll resend it if necessary.

	Arnd

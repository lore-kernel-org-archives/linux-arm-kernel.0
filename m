From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 22:43:00 +0000
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303052325.13143.heiko@sntech.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303052154.22857.arnd@arndb.de> <201303052325.13143.heiko@sntech.de>
Message-ID: <201303052243.00681.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Heiko St?bner wrote:
> Am Dienstag, 5. M?rz 2013, 22:54:22 schrieb Arnd Bergmann:
> > On Tuesday 05 March 2013, Arnd Bergmann wrote:
> 
> > We still need a solution for the ASoC drivers, but they are
> > not as essential. We could probably move the wrapper files
> > from plat-samsung/*dma*.c to sounds/soc/samsung when that becomes
> > the only remaining user.
> 
> In ASoC there is also a clear distinction between the different SoC
> generations. SND_SAMSUNG_I2S /_PCM /_AC97 ... is only used by newer SoCs
> while SND_S3C24XX_I2S and SND_S3C_I2SV2_SOC is used by the legacy SoCs.

Well, the only file that really needs to get changed is dma.c, which
seems to be used by both the old and the new drivers.

	Arnd

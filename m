From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 05 Mar 2013 23:12:31 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303052154.22857.arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303052124.04101.arnd@arndb.de> <201303052154.22857.arnd@arndb.de>
Message-ID: <681263925.o7yR7PPoHR@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 of March 2013 21:54:22 Arnd Bergmann wrote:
> On Tuesday 05 March 2013, Arnd Bergmann wrote:
> > The s3c64xx_dma code is also interesting because
> > it has both an implementation of the s3c_dma interface in
> > arch/arm/mach-s3c64xx/dma.c and one using the generic interface in
> > drivers/dma/amba-pl08x.c.
> 
> This actually brings me to an interesting idea: the s3c64xx SPI driver
> is used with the regular dmaengine API and pl330 on S5P and Exynos,
> but with the s3c-dma interface and pl080 on S3C64xx.
> 
> If we just convert S3C64xx to use the pl080 dmaengine driver
> instead, we can apply my SPI patch without breaking anything.

AFAIR, the PL080 in S3C64xx is a slightly customized variant and requires 
some modifications to the driver. However I'm saying this only based on 
what I remember from the past, as I haven't checked current version of the 
driver yet, so it's possible that it has been modified already.

I believe I will eventually have to take a look at it anyway, as it's a 
necessary step towards S3C64xx DT support.

Best regards,
Tomasz

> We still need a solution for the ASoC drivers, but they are
> not as essential. We could probably move the wrapper files
> from plat-samsung/*dma*.c to sounds/soc/samsung when that becomes
> the only remaining user.
> 
> There is also drivers/mmc/host/s3cmci.c, which uses the s3c-dma
> interface, but it is only used on s3c24xx, not s3c64xx or later.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to
> majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

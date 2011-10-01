From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 23:44:21 +0100
Subject: [PATCH 1/2 v2] plat-pxa: move PXA GPIO driver to GPIO subsystem
In-Reply-To: <1317121005-4716-1-git-send-email-linus.walleij@stericsson.com>
References: <1317121005-4716-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111001224421.GQ11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 12:56:45PM +0200, Linus Walleij wrote:
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index a4c8ac9..828e9ab 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
>  obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
>  obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
>  obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
> +obj-$(CONFIG_PLAT_PXA)		+= gpio-pxa.o
>  obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
>  obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
>  obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o

This is not what my drivers/gpio/Makefile contains.  I've applied this
patch with GNU patch with fuzz 2, resulting in:

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 84bc738..19c5d27 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)    += gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)     += gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)         += gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)       += gpio-pl061.o
+obj-$(CONFIG_PLAT_PXA)         += gpio-pxa.o
 obj-$(CONFIG_GPIO_RDC321X)     += gpio-rdc321x.o

 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)        += gpio-plat-samsung.o

This will probably conflict with Grant's tree.

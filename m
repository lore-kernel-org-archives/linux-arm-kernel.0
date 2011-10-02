From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 2 Oct 2011 23:24:29 +0200
Subject: [PATCH 1/2 v2] plat-pxa: move PXA GPIO driver to GPIO subsystem
In-Reply-To: <20111001224421.GQ11710@n2100.arm.linux.org.uk>
References: <1317121005-4716-1-git-send-email-linus.walleij@stericsson.com>
	<20111001224421.GQ11710@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MqEd92jizWe-fTf=YkxHaVgNsQBXR6w33ZNjF9fx26PNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Sep 27, 2011 at 12:56:45PM +0200, Linus Walleij wrote:
>> ?obj-$(CONFIG_GPIO_PL061) ? ? += gpio-pl061.o
>> +obj-$(CONFIG_PLAT_PXA) ? ? ? ? ? ? ? += gpio-pxa.o
>> ?obj-$(CONFIG_GPIO_RDC321X) ? += gpio-rdc321x.o
>
> This is not what my drivers/gpio/Makefile contains. ?I've applied this
> patch with GNU patch with fuzz 2, resulting in:
>
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 84bc738..19c5d27 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X) ? ?+= gpio-pca953x.o
> ?obj-$(CONFIG_GPIO_PCF857X) ? ? += gpio-pcf857x.o
> ?obj-$(CONFIG_GPIO_PCH) ? ? ? ? += gpio-pch.o
> ?obj-$(CONFIG_GPIO_PL061) ? ? ? += gpio-pl061.o
> +obj-$(CONFIG_PLAT_PXA) ? ? ? ? += gpio-pxa.o
> ?obj-$(CONFIG_GPIO_RDC321X) ? ? += gpio-rdc321x.o
>
> ?obj-$(CONFIG_GPIO_PLAT_SAMSUNG) ? ? ? ?+= gpio-plat-samsung.o
>
> This will probably conflict with Grant's tree.

Yes luckily it looks pretty trivial.

Haojioan is working on cleanups to this driver that need to be rebased
on top of this and submitted through your branch in order for us not
to create even more conflicts.

Feel free to drop any of this stuff if it's just causing trouble, it can
surely wait until the next merge window if need be.

Yours,
Linus Walleij

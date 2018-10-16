From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 13:35:44 +0200
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <20181016084416.GF30658@n2100.armlinux.org.uk>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
Message-ID: <CACRpkdavnYDE42GOwsVqnLwqjVmLmkwJ=sQBjUFn=aFbqXqVPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:44 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:

> > I am on deep waters with ARM assembly, admittedly. So I wanted to
> > ask: OpenWRT has this cache patch:
> > https://github.com/openwrt/openwrt/blob/master/target/linux/gemini/patches-4.14/0001-cache-patch-from-OpenWRT.patch
> > I do not know why (sorry).
> >
> > Do you think that patch is actually a hack to hide the problem
> > fixed with this patch? (OK maybe stupid question but...)
>
> No, it looks to me like a hack to make DMA cache handling "more
> efficient" by cleaning/invalidating the entire cache when dealing
> with large streaming buffers.

Aha that makes a lot of sense.

I will attempt to drop it from OpenWRT in the next kernel upgrade
unless benchmarks can show that it is worth it.

Thanks Russell!

Linus Walleij

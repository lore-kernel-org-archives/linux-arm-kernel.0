From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 21:54:17 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <3062977.Ya2ztQYFaM@wuerfel> (Arnd Bergmann's message of "Tue, 16
 Feb 2016 14:55:43 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <2702068.KRp0Bplb5Q@wuerfel> <m34md8rdol.fsf@t19.piap.pl>
 <3062977.Ya2ztQYFaM@wuerfel>
Message-ID: <87povrxfuu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Coming back to the specific pxa25x_udc case: using __raw_* accessors
> in the driver would possibly end up breaking the PXA25x machines in
> the (very unlikely) case that someone wants to make it work with
> big-endian kernels, assuming it does not have the same hardware
> byteswap logic as ixp4xx.

As far as I know, pxa25x machine implies the kernel is little endian. From an
hardware perspective, pxa25x doesn't support big endian (old ARM platform).

So I don't think considering BE for pxa25x is ... necessary.

Cheers.

-- 
Robert

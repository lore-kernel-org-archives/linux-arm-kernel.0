From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 13 Dec 2012 23:36:25 +0800
Subject: [PATCH] ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
In-Reply-To: <20121212184215.GC14363@n2100.arm.linux.org.uk>
References: <1355317277-32192-1-git-send-email-shawn.guo@linaro.org>
 <20121212184215.GC14363@n2100.arm.linux.org.uk>
Message-ID: <20121213153623.GA1856@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 06:42:15PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 12, 2012 at 09:01:17PM +0800, Shawn Guo wrote:
> > ARCH_HAS_DECOMP_WDOG is only used in lib/inflate.c which is not
> > included in arch/arm/boot/compressed/decompress.c now.  That said,
> > ARCH_HAS_DECOMP_WDOG is not used at all.  Let's remove it.
> 
> There are some implementations of the watchdog callbacks - I wonder
> if the change to the decompressor code has broken those and no one's
> noticed.  They seem to be Samsung platforms.

I noticed the implementations on Samsung platforms.  But they are all
wrapped by CONFIG_S3C_BOOT_WATCHDOG which is not defined any where.
So if you agree with the patch, I will send another follow-up to
Samsung maintainer removing all those dead codes.

Shawn

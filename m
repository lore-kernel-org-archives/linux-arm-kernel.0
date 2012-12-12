From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Dec 2012 18:42:15 +0000
Subject: [PATCH] ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
In-Reply-To: <1355317277-32192-1-git-send-email-shawn.guo@linaro.org>
References: <1355317277-32192-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121212184215.GC14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 09:01:17PM +0800, Shawn Guo wrote:
> ARCH_HAS_DECOMP_WDOG is only used in lib/inflate.c which is not
> included in arch/arm/boot/compressed/decompress.c now.  That said,
> ARCH_HAS_DECOMP_WDOG is not used at all.  Let's remove it.

There are some implementations of the watchdog callbacks - I wonder
if the change to the decompressor code has broken those and no one's
noticed.  They seem to be Samsung platforms.

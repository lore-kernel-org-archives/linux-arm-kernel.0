From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 17:58:08 +0000
Subject: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
In-Reply-To: <7534695.eTHcH0enMV@wuerfel>
References: <7534695.eTHcH0enMV@wuerfel>
Message-ID: <20130315175808.GT4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 11:01:35PM +0100, Arnd Bergmann wrote:
> gcc-4.7 and higher add a lot of false positive warnings about
> potential uses of uninitialized warnings, but only when optimizing
> for size (-Os). This is the default when building allyesconfig,
> which turns on CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> In order to avoid getting a lot of patches that initialize such
> variables and accidentally hide real errors along the way, let's
> just turn off this warning on the respective gcc versions
> when building with size optimizations. The -Wmaybe-uninitialized
> option was introduced in the same gcc version (4.7) that is now
> causing the false positives, so there is no effect on older compilers.
> 
> A side effect is that when building with CONFIG_CC_OPTIMIZE_FOR_SIZE,
> we might now see /fewer/ warnings about possibly uninitialized
> warnings than with -O2, but that is still much better than seeing
> warnings known to be bogus.

What about truely uninitialized uses of variables?  Will this hide
their warning too?

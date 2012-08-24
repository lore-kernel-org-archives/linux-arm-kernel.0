From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 21:19:38 +0800
Subject: [PATCH 0/4] [RFC] ARM: multiplatform: rename all mach headers
In-Reply-To: <201208221253.07278.arnd@arndb.de>
References: <201208221253.07278.arnd@arndb.de>
Message-ID: <20120824131935.GF31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 12:53:06PM +0000, Arnd Bergmann wrote:
> I've created this series some time ago, and updated it now to
> v3.6-rc1. The idea is to get us a big step closer to the
> single zImage kernel across multiple ARM platforms by
> untangling the duplicate header file names.
> 
> There are two branches available in the arm-soc tree:
> 
> 1. This series,
>    http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/testing/mach-headers
>    This just moves header files around and changes most of the
>    files including them. There are a few remaining drivers
>    and platform files that keep including a generic file name
>    like <mach/uncompress.h>. It remains possible to do that,
>    and I've run extensive tests to ensure I did not break
>    anything with this. However, each of these instances means
>    that there is something that stops working when you get to
>    the real multiplatform kernel and we still need to deal
>    with them one by one.
> 
> 2. Actually enabling CONFIG_ARCH_MULTIPLATFORM
>    http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/testing/multiplatform
>    This builds on top of the first series, but is much more
>    experimental. It shows how a multiplatform kernel can look
>    like, by allowing to build vexpress, ux500, imx and omap2
>    together in one kernel, but at the same time breaking some of
>    their features.
> 
I just merged Marc's smp_ops branch below into above branch, and built
a kernel from there with vexpress and imx support together.

 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git smp_ops-v3.5-rc2

The kernel boots fine on both imx5 and imx6, and I did not notice any
obvious feature breaking \o/

-- 
Regards,
Shawn

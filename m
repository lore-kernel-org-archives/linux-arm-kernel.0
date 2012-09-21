From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 21:58:14 -0700
Subject: [GIT PULL] ARM initial multi-platform support
In-Reply-To: <5053B05C.7070801@gmail.com>
References: <5053B05C.7070801@gmail.com>
Message-ID: <20120921045814.GA30535@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 05:31:56PM -0500, Rob Herring wrote:
> Arnd, Olof,
> 
> Please pull initial multi-platform support. This includes the gpio.h
> clean-up that's needed as well. Hopefully it's early enough we will see
> a few other platforms converted over for 3.7.
> 
> There's a few minor changes from the last version I posted:
> - Incorporated Jamie Iles fixes for picoxcell.
> - Removed the now unused vexpress uncompress.h and timex.h
> - Fixed the multiple adding of mach directories for spear and exynos.
> - Fixed orion gpio.h includes breaking dove, kirkwood, and orion5x.
> 
> Rob
> 
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:
> 
>   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)
> 
> are available in the git repository at:
> 
>   git://sources.calxeda.com/kernel/linux.git tags/multi-platform-for-3.7
> 
> for you to fetch changes up to 617276307cd4cdb9a95c77efaa3063695af63aa7:
> 
>   ARM: vexpress: convert to multi-platform (2012-09-14 12:55:09 -0500)

I pulled in this branch now. I created a new next/multiplatform branch that
contains this branch plus one more patch to sweep new dtb targets and move
them to the common file (will post that patch shortly).

To avoid the worst of the conflicts I ended up basing next/multiplatform on
next/cleanup + next/dt + next/soc.

Note that I have not yet merged in the smp_ops branch (will do final
sync-up with Arnd on that tomorrow), so selecting multiple targets will
fail building due to duplicate symbols.


-Olof

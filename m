From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Sep 2012 16:01:43 +0000
Subject: [PATCH] ARM: mvebu: fix build breaks from multi-platform
 conversion
In-Reply-To: <20120927172618.7ba233f0@skate>
References: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
 <20120927172618.7ba233f0@skate>
Message-ID: <201209271601.43717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 September 2012, Thomas Petazzoni wrote:
> This select was already part added as a part of:
> 
> commit 7e8d941567c99a03390154a7bb116d1b03db82b3
> Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date:   Thu Sep 13 17:41:43 2012 +0200
> 
>     pinctrl: mvebu: pinctrl driver core
>     
>     This patch adds a pinctrl driver core for Marvell SoCs plus DT
>     binding documentation. This core driver will be used by SoC family
>     specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.
>     
>     Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>     Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>     Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>     Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>     Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
>     Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>     
>     Conflicts:
>     
>         arch/arm/Kconfig
> 
> which was requested for pull from the kirkwood/drivers branch of Jason
> Cooper repository. If it is no longer there, then it is a merge
> conflict resolution mistake.

I believe it was lost again in the move to the multiplatform configuration,
which moves the ARCH_MVEBU definition to arch/arm/mach-mvebu/Kconfig.
automated merges with git don't notice this. Same for the other one.

	Arnd

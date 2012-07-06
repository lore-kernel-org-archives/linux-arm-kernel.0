From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 6 Jul 2012 12:47:36 +0200
Subject: [PATCH 1/1] ARM: ux500: Register the AB8500 from DB8500 MFD
In-Reply-To: <1341567340-5800-1-git-send-email-lee.jones@linaro.org>
References: <1341567340-5800-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120706104736.GA15345@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Jul 06, 2012 at 10:35:40AM +0100, Lee Jones wrote:
> As the AB8500 is a subordinate MFD device to the DB8500-PRCMU,
> for consistency and a better 1:1 depiction of how the hardware
> is laid out, it is a good idea to register it in the same way
> as we do for the other MFD child devices. In order for us to do
> this successfully we have to pass AB8500's platform data when
> registering the DB8500-PRCMU from platform code.
> 
> Also solves this issue:
> WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0x88/0xb0()
> sysfs: cannot create duplicate filename '/bus/platform/devices/ab8500-core.0'
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c       |   27 +++------------------------
>  arch/arm/mach-ux500/cpu-db8500.c         |    7 +++++--
>  arch/arm/mach-ux500/include/mach/setup.h |    3 ++-
>  drivers/mfd/db8500-prcmu.c               |   10 +++++++++-
>  4 files changed, 19 insertions(+), 28 deletions(-)
Patch applied, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

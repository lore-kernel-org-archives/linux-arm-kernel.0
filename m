From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Jan 2014 13:42:40 -0700
Subject: [PATCH 3/5] ARM: firmware: enable Trusted Foundations by default
In-Reply-To: <1390299016-14105-4-git-send-email-acourbot@nvidia.com>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
 <1390299016-14105-4-git-send-email-acourbot@nvidia.com>
Message-ID: <52E02D40.3090803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 03:10 AM, Alexandre Courbot wrote:
> As discussed previously (https://lkml.org/lkml/2013/11/26/289), enable
> Trusted Foundation support by default since it already depends on a
> supporting architecture being selected.
> 
> Doing so allows us to remove it from tegra_defconfig.

>  arch/arm/configs/tegra_defconfig | 1 -
>  arch/arm/firmware/Kconfig        | 1 +

Can we split out the defconfig and code changes into separate patches?
They need to go through seperate branches, possibly even separate repos.

The defconfig change might not even be necessary; at some point I'll
just rebuild it via "make tegra_defconfig; make savedefconfig" on top of
some linux-next that includes the Kconfig change, and it'll happen
automatically. Still, I guess there's no harm explicitly sending the patch.

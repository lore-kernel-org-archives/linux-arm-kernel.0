From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:21:40 +0100
Subject: [GIT PULL 6/6] i.MX defconfig updates for 4.17
In-Reply-To: <1521113800-16401-6-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-6-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a2mUiAQRUZSvTwX=9ukEY6LWPTFqj=9WwWf2=OO3L-q7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.17
>
> for you to fetch changes up to e3e583e7a293ae3fddfe010ed30d80046ba87c86:
>
>   ARM: mxs_defconfig: Re-sync defconfig (2018-03-08 16:46:11 +0800)
>
> ----------------------------------------------------------------
> i.MX defconfig updates for 4.17:
>  - Re-sync defconfig files by running savedefconfig.

I didn't pull this one, it seems to remove some config symbols without
an explanation what happened to them:

-CONFIG_FHANDLE=y
-# CONFIG_ARM_THUMB is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
-# CONFIG_DEVKMEM is not set
-CONFIG_NVMEM=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_TIMER_STATS=y

Can you have another look? I want to be sure that we don't
accidentally turn off something important when the respective
Kconfig symbol got renamed or it gained a dependency that
is no longer met.

Thanks,

         Arnd

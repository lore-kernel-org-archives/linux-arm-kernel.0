From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:33:49 +0200
Subject: [GIT PULL 2/5] soc/tegra: Changes for v4.14-rc1
In-Reply-To: <20170818144806.14252-2-thierry.reding@gmail.com>
References: <20170818144806.14252-1-thierry.reding@gmail.com>
 <20170818144806.14252-2-thierry.reding@gmail.com>
Message-ID: <CAK8P3a1ditcQq_3TdkXQ3VAqcog5CUGsJQvqm9KJoJCi41zOoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 4:48 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Hi ARM SoC maintainers,
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-soc
>
> for you to fetch changes up to 27a0342ac162bf2ba30c288cfb7b72eabed38d8b:
>
>   soc/tegra: Register SoC device (2017-08-17 16:43:13 +0200)
>
> ----------------------------------------------------------------
> soc/tegra: Changes for v4.14-rc1
>
> Contains a fix for unbalanced reference counting of device tree nodes in
> the PMC-based generic power domains code.
>
> A second change moves the SoC device registration code from its old
> location in arch/arm/mach-tegra to drivers/soc/tegra so that it can be
> shared between 32-bit and 64-bit ARM Tegra SoCs.

Ok. I noticed this part in the changelog:

    Move this code from arch/arm/mach-tegra and make it common among 32-bit
    and 64-bit Tegra SoCs. This is slightly complicated by the fact that on
    32-bit Tegra, the SoC device is used as the parent for all devices that
    are instantiated from device tree.

Have you considered whether we can change the behavior on arm32?
Usually nothing cares about the hierarchy in sysfs, though there is of
course a theoretical risk of something breaking.

I pulled your branch into next/drivers, if you decide to change the
arm32 behavior, just send a patch on top. Thanks,

     Arnd

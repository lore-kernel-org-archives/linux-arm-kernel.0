From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 Apr 2014 10:39:37 -0600
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
Message-ID: <535A8FC9.8040707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 01:21 AM, Brian Norris wrote:
> These defconfigs contain the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
> relevant defconfigs.
> 
> At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

I hadn't realized that the problem this patch solves was already present
in the code, so this patch is simply catching up the defconfigs rather
than part of a series which changed the code to cause the problem.

So, this needs to be applied ASAP.

I think this should be split it up so that each defconfig can go through
the tree that owns it to avoid conflicts. If you repost split up, I can
apply the tegra_defconfig change to the Tegra tree.

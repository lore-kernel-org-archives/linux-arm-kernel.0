From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 12 Apr 2013 09:40:17 -0600
Subject: [PATCH 2/2] ARM: remove all trivial init_machine callbacks
In-Reply-To: <1365779468-116419-2-git-send-email-arnd@arndb.de>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <1365779468-116419-2-git-send-email-arnd@arndb.de>
Message-ID: <51682AE1.9090106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2013 09:11 AM, Arnd Bergmann wrote:
> The call to of_platform_populate(NULL, of_default_bus_match_table, NULL,
> NULL) is now implied by having no init_machine callback in the machine
> descriptor, so we can save a couple of lines in those machines that
> do not need to do anything else.

>  arch/arm/mach-tegra/board-dt-tegra114.c |  6 ------
>  arch/arm/mach-tegra/board-dt-tegra30.c  |  6 ------

Those two files don't exist any more; they were merged with
board-dt-tegra20.c and all squashed into the new tegra.c.

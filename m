From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Aug 2011 10:59:55 +0200
Subject: [PATCH 1/3] ARM: mmp: add sram allocator
In-Reply-To: <1313377794-26721-2-git-send-email-leoy@marvell.com>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
Message-ID: <1403041.Yj2MdIhcZO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 August 2011 11:09:52 Leo Yan wrote:
> On mmp platform, there have two sram banks:
> audio sram and internal sram. The audio sram is mainly for audio;
> the internal sram is for video, wtm and power management.
> So add the sram allocator using genalloc to manage them.
> 
> Every sram bank will register its own platform device
> info, after the sram allocator create the generic pool
> for the sram bank, the user module can use the pool's
> name to get the pool handler; then it can use the handler
> to alloc/free memory with genalloc APIs.
> 
> Signed-off-by: Leo Yan <leoy@marvell.com>
> ---
>  arch/arm/Kconfig                      |    1 +
>  arch/arm/mach-mmp/Makefile            |    2 +-
>  arch/arm/mach-mmp/include/mach/sram.h |   35 +++++++
>  arch/arm/mach-mmp/sram.c              |  168 +++++++++++++++++++++++++++++++++
>  4 files changed, 205 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
>  create mode 100644 arch/arm/mach-mmp/sram.c

Some time ago, there was talk of merging the existing sram drivers
and creating a common driver that is easy to hook into.

What has happened with that? My feeling is that we should stop adding
more drivers like this in the platform code but rather put an
authoritative copy into arch/arm/mm/ or even the top-level mm/ directory
and change over the existing drivers to hook into that one.

	Arnd

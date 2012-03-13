From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 12:35:53 +0000
Subject: [PATCH v4 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
Message-ID: <201203131235.53593.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Ryan Mallon wrote:
> This patch series is an effort to move the ep93xx SoC specific code out
> of drivers and include/mach into arch/arm/mach-ep93xx. This work
> involves the following changes:
> 
>  - Create a new private header called soc.h to replace most of 
>    mach/include/ep93xx-regs.h
>  - Move the Maverick crunch code from arch/arm/kernel to mach-ep93xx
>  - Convert the ep93xx backlight and watchdog drivers to properly
>    ioremap memory.
>  - Move all system controller access to the ep93xx core code
> 
> The only defines left in ep93xx-regs.h are for the APB UARTS which
> are also needed in include/mach/uncompress.h and
> include/mach/debug-macro.S.
> 
> Patch 2 has already been merged to the ASoC tree and patch 5 has
> already been merged to the watchdog tree. Neither patch has been
> modified since they were applied, and are included here for
> completeness and to avoid build errors. 

Looks all very nice, great work!

> All of the patches are against v3.3-rc7 and  now have reviewed-by
> and/or acked-by tags except for patch 4 which has been changed
> since the last version. Arnd, once I get an ack for the final patch
> I can prepare a git branch for you to pull. I understand if this is
> now too late for v3.4.

If there are no conflicts against the for-next branch and Olof agrees,
I would probably let this one go in for v3.4. It's a nice cleanup
and it will be easier to do your v3.5 patches if it's all merged.

On a related note, I would like to understand better what your plans
are for the future of ep93xx. My undestanding is that the product line
is a dead end and there won't be any other compatible socs, but the
Linux support is very much alive and supports all the existing hardware,
is that correct?

There are currently eight board files (since all the dev boards got
merged into one file), which seems very manageable and there should be
no problem adding a few more over the years to come, if necessary.

At the same time, the platform seems simple enough that you could
also do a device tree port in rather in a fairly short time if you
like, which would let you obsolete all the board files and add new
machines just through device tree blobs.

	Arnd

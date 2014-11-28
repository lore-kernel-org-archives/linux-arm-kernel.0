From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 12:28:52 +0100
Subject: [GIT PULL] move omap gpmc to drivers finally
In-Reply-To: <20141126194330.GN2817@atomide.com>
References: <20141126194330.GN2817@atomide.com>
Message-ID: <201411281228.52786.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014, Tony Lindgren wrote:
> The following changes since commit 6f8782a7a1c826e1c013d6b7d5504af6bcc079e6:
> 
>   ARM: OMAP2+: Remove unnecesary include in GPMC driver (2014-11-06 10:51:06 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gpmc-move
> 
> for you to fetch changes up to d2c70f553d7203b9bb37730e577be29794ae3169:
> 
>   memory: gpmc: Move omap gpmc code to live under drivers (2014-11-26 11:11:19 -0800)
> 
> ----------------------------------------------------------------
> We can finally move the GPMC code to live in drivers/memory
> for further clean up work. This series does the move with
> minimal changes to the code.

I just looked at this branch. It's definitely nice to move the code
to drivers/memory, but I don't like the idea of having lots of function
declarations and internal data structures in a linux/platform_data/*.h
file. We can still merge this for 3.19, but I want to make sure you have
a plan for getting rid of this (and put that into the tag description).

Does this header file get removed once all non-DT board files are gone?

How about moving the declarations into include/linux/omap-gpmc.h instead?

	Arnd

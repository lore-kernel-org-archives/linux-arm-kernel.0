From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2011 14:28:03 +0000
Subject: [GIT PULL] DaVinci cleanup for v3.3
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6048974@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6048974@DBDE01.ent.ti.com>
Message-ID: <201112161428.03412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 December 2011, Nori, Sekhar wrote:
> I have this lone patch queued for DaVinci clean-up so far.
> Can you please pull this?
> 
> The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:
>   Linus Torvalds (1):
>         Linux 3.2-rc3
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-davinci/linux-davinci.git v3.3/cleanup
> 

Pulled into next/cleanups, but not happy about the patch.

While the patch is a move in the right direction, it is not sufficient for
what you intend with it:

Author: Manjunath Hadli <manjunath.hadli@ti.com>
Date:   Sat Nov 12 20:36:02 2011 +0530

    ARM: davinci: vpif: move code to driver core header from platform
    
    Move vpif related definitions for capture and display drivers
    from dm646x platform header file to vpif_types.h inside
    the driver as these definitions are related to driver code
    rather than the platform or board.
    
    This enables reusing this IP across platforms.

If you really want to use the same IP on future platforms, the correct
approach would be to get rid of the requirement for having platform-
specific callbacks and setup data, and replace it all with device tree
based probing. I can understand that you consider mach-davinci legacy
code and don't want to rework it in significant ways, but if a driver
that is used in there is not legacy code, it should be updated to the
modern ways of doing this.

	Arnd

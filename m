From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Feb 2014 21:20:31 +0100
Subject: [PATCH v4 03/22] ARM: Kirkwood: Convert mv88f6281gtw_ge switch
 setup to DT
In-Reply-To: <20140222195016.GD7862@titan.lakedaemon.net>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
 <1393096504-11844-4-git-send-email-andrew@lunn.ch>
 <20140222195016.GD7862@titan.lakedaemon.net>
Message-ID: <20140222202031.GH6667@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 02:50:16PM -0500, Jason Cooper wrote:
> On Sat, Feb 22, 2014 at 08:14:45PM +0100, Andrew Lunn wrote:
> > The mv88f6281gtw_ge has a ethernet switch connected to the ethernet
> > port of the SoC. Convert the platform device instantiation to a DT
> > instantiation.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Cc: florian at openwrt.org
> > ---
> > v2
> > Remove the spurius Module.symvers
> > Really do describe the switch in DT.
> > ---
> >  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 62 ++++++++++++++++++++++++++
> >  arch/arm/mach-kirkwood/Kconfig                 |  7 ---
> >  arch/arm/mach-kirkwood/Makefile                |  1 -
> >  arch/arm/mach-kirkwood/board-dt.c              |  3 --
> >  arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c | 50 ---------------------
> >  arch/arm/mach-kirkwood/common.h                |  7 ---
> >  6 files changed, 62 insertions(+), 68 deletions(-)
> >  delete mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
> 
> You know, I think this is the last time we'll have to tie code changes
> and dts file changes together...

Humm, if we part convert T5325 and OpenRD it won't be.

      Andrew

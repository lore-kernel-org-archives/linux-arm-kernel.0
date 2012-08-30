From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2012 20:08:53 +0200
Subject: [PATCH] ARM: Kirkwood: Fix 'SZ_1M' undeclared here for
 db88f6281-bp-setup.c
In-Reply-To: <20120830171236.GS19437@titan.lakedaemon.net>
References: <1346305152-14618-1-git-send-email-andrew@lunn.ch>
 <20120830171236.GS19437@titan.lakedaemon.net>
Message-ID: <20120830180853.GP9886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 01:12:36PM -0400, Jason Cooper wrote:
> On Thu, Aug 30, 2012 at 07:39:12AM +0200, Andrew Lunn wrote:
> > Linux-next has failed to compile for kirkwood since 23 August with:
> > 
> > arch/arm/mach-kirkwood/db88f6281-bp-setup.c:29: error: 'SZ_1M' undeclared here (not in a function)
> > arch/arm/mach-kirkwood/db88f6281-bp-setup.c:33: error: 'SZ_4M' undeclared here (not in a function)
> > 
> > Add missing <linux/sizes.h>
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Applied to: fixes-for-v3.6
> 
> Also, I added a CC for stable so greg can pick it up.

Hi Jason

Stable does not need it. As i said, it only broke 23 August with
linux-next. So this is needed for only 3.7.

	    Andrew

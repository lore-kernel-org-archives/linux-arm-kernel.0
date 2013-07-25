From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 17:07:55 -0400
Subject: [PATCH 2/2] ARM: orion5x: add missing mbus include
In-Reply-To: <20130725153856.GI23879@titan.lakedaemon.net>
References: <1372762453-12018-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1372762453-12018-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130725153856.GI23879@titan.lakedaemon.net>
Message-ID: <20130725210755.GZ23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:38:56AM -0400, Jason Cooper wrote:
> On Tue, Jul 02, 2013 at 12:54:13PM +0200, Sebastian Hesselbarth wrote:
> > edmini_v2-setup is missing an include of linux/mbus.h which causes
> > compiler error because of missing reference to mvebu_mbus_add_window.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Cc: Russell King <linux@arm.linux.org.uk> 
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Gregory CLEMENT <gregory.clement@free-electrons.com> 
> > Cc: devicetree-discuss at lists.ozlabs.org 
> > Cc: linux-kernel at vger.kernel.org 
> > Cc: linux-arm-kernel at lists.infradead.org 
> > ---
> >  arch/arm/mach-orion5x/edmini_v2-setup.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> Applied to mvebu/stable-3.10

nevermind, Olof caught that v3.10 builds fine without this patch (I
should've checked).  The build error was introduced by

  ARM: orion5x: remove legacy mv643xx_eth board setup

which removed mv643xx_eth.h include, which had included the needed
mbus.h.  This patch is queued for v3.12.

I'll squash this patch into the above mentioned patch and call it a day.

thx,

Jason.

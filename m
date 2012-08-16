From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Aug 2012 09:35:21 -0400
Subject: [PATCH v2 1/2] ARM: kirkwood: DT board setup for Seagate
 FreeAgent Dockstar
In-Reply-To: <20120814232256.GX22226@titan.lakedaemon.net>
References: <20120814193613.GS22226@titan.lakedaemon.net>
 <1344977022-29037-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120814232256.GX22226@titan.lakedaemon.net>
Message-ID: <20120816133521.GP22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 07:22:56PM -0400, Jason Cooper wrote:
> On Tue, Aug 14, 2012 at 10:43:41PM +0200, Sebastian Hesselbarth wrote:
> > This add a DT compatible board specific setup for the Seagate
> > FreeAgent Dockstar.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > 
> > v2: rebased on git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6
> 
> patches [1/2] and [2/2] of this series applied to:
> 
>   git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7
> 
> patch [2/2] depends upon:
> 
>   bda63c1 ARM: Kirkwood: fix Makefile.boot
> 
> which should be in an upcoming v3.6-rc

Oops, building with both legacy and DT support for the Dockstar yields
the following error:

arch/arm/mach-kirkwood/dockstar-setup.c:81:20: error: static declaration
of 'dockstar_init' follows non-static declaration
arch/arm/mach-kirkwood/common.h:86:6: note: previous declaration of
'dockstar_init' was here
make[1]: *** [arch/arm/mach-kirkwood/dockstar-setup.o] Error 1
make: *** [arch/arm/mach-kirkwood] Error 2

As a quick fix I renamed your dockstar_init() to dockstar_dt_init()
across your patch.  This compiles clean.  Unfortunately, I can't send
this fix up as a separate patch (a bisect may land in between it and
yours).

Unless I hear otherwise from you in the next day or so, I'm going to
collapse the fix into your patch and push it that way.

thx,

Jason.

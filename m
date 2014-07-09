From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 13:39:50 +0100
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power
 control setting
In-Reply-To: <53BD34FD.5070005@ti.com>
References: <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
 <20140707151024.GJ5582@saruman.home> <53BB7980.2060909@ti.com>
 <20140708082948.GE28884@atomide.com> <20140709092531.GK28884@atomide.com>
 <53BD34FD.5070005@ti.com>
Message-ID: <20140709123950.GV3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:56:37PM +0530, Sekhar Nori wrote:
> On Wednesday 09 July 2014 02:55 PM, Tony Lindgren wrote:
> > I guess no more comments. Took a look at the patch again, Sekhar, can
> > you please update the description with what has been discovered in this
> > thread and repost?
> 
> How does the following sound:
> 
> ---
> AM437x has L2C-310 version r3p2 and ROM code on that device does not
> support writing to L2C-310 power control register. The L2C driver,
> however, tries writing to this register for all revisions >= r3p0.
> 
> This leads to a warning dump on boot which leads most users to believe
> that L2 cache is non-functional.
> 
> Since the problem is understood, and cannot be addressed through
> software, replace the warning with a pr_info() while maintaining the
> WARN_ON() for other truly unexpected scenarios.
> 
> >From the public TRM available for OMAP4470, even on that device, ROM
> does not support writing to this register even though it uses a version
> of L2C-310 which has the register implemented. So this patch should take
> care of all variants of existing OMAPs.
> ---

That sounds perfect, and explains why the change has to exist, and why
it can't be fixed elsewhere.  Thanks for providing the full reasoning in
the commit message.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

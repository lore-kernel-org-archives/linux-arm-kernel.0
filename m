From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 14:52:43 +0000
Subject: [PATCH] arm64: dts: berlin4ct: switch to Cortex-A53 specific pmu
 nodes
In-Reply-To: <20151215224709.2d71d2ba@xhacker>
References: <1450190172-1161-1-git-send-email-jszhang@marvell.com>
 <8261316.NuheDtlQ6N@wuerfel> <20151215224709.2d71d2ba@xhacker>
Message-ID: <20151215145243.GB7041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:47:09PM +0800, Jisheng Zhang wrote:
> Dear Arnd,
> 
> On Tue, 15 Dec 2015 15:43:53 +0100 Arnd Bergmann wrote:
> 
> > On Tuesday 15 December 2015 22:36:12 Jisheng Zhang wrote:
> > > -               compatible = "arm,armv8-pmuv3";
> > > +               compatible = "arm,cortex-a53-pmu";
> > >   
> > 
> > Should this list both?
> 
> IMHO, we don't need to list both. The pmu binding document also says:
> "compatible : should be one of ...."
> 
> Dear Mark,
> 
> Could you please give suggestions?

That should probably reads as "should contain at least one of".

It's probably best to keep "arm,armv8-pmuv3" as a fallback in the
compatible list.

Thanks,
Mark.

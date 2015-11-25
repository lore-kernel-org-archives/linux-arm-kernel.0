From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 25 Nov 2015 11:53:36 +0000
Subject: suspicious RCU usage on 4.4-rc2 ARM platform
In-Reply-To: <20151124165206.GQ26643@linux.vnet.ibm.com>
References: <20151124162750.GE20439@e106622-lin>
 <20151124165206.GQ26643@linux.vnet.ibm.com>
Message-ID: <20151125115336.GF20439@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/15 08:52, Paul E. McKenney wrote:
> On Tue, Nov 24, 2015 at 04:27:50PM +0000, Juri Lelli wrote:
> > Hi Paul,
> > 
> > I'm hitting these splats while running simple hotplug tests on an ARM
> > TC2 platform. The following seems to cure it, but I don't think it never
> > made it to mainline:
> > 
> >  https://lkml.org/lkml/2015/5/12/892 
> > 
> > Any reason why?
> 
> If I remember correctly, it could result in failures on some ARM
> processors.  The problem was that this patch assumes that the CPU
> caches remain active throughout, when in fact they can be disabled at an
> inconvenient time.  As I understand it, this can result in other updates
> to that cache line being lost when the CPU is powered off.
> 
> RMK would know more.
> 

Paul, Russell,

thanks for confirming that this is a know problem; I just wanted to be
sure I'm not seeing something new. I guess I'll keep using this fix on
my box while I wait for a proper one.

Best,

- Juri

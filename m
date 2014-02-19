From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 19:32:11 +0100
Subject: [PATCH v4 12/13] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
In-Reply-To: <5304E7B7.3040206@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com>
 <20140219175145.4b4fcba5@skate>
 <5304E7B7.3040206@free-electrons.com>
Message-ID: <20140219193211.10dd2f22@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 19 Feb 2014 18:19:51 +0100, Gregory CLEMENT wrote:

> > Sorry to bring the naming issue, but it looks like the Armada 38x has a
> > PMSU that looks almost identical to the Armada XP PMSU, except that it
> > doesn't have the L2 fabric registers (probably because Armada 38x uses
> > the PL310 and not the Marvell L2 cache).
> > 
> > Therefore, should this cpuidle driver be named Armada 370/XP, or
> > ARMADA_MVEBU for example?
> 
> Well most of the code is related to the coherency and the L2 cache, so
> a different L2 cache is a significant difference. The CPU are also different
> for example the PJ4B can  use LDREX/STREX without MMU whereas the Cortex A9
> can't.

Right, ok.

> > Also, I'm a bit unsure about your choice of mixing C and assembly here.
> > This function is already calling ll_clear_cpu_coherent() and
> > ll_set_cpu_coherent() that are assembly functions implement in
> > coherency_ll.S. Shouldn't we do the same for this final bit of assembly?
> 
> I made several tries when I converted most of the code in C, so I am not
> sure but I think that using a C function didn't work here. But as Lorenzo
> pointed they were mistakes in this code, so once I will have fixed them, I
> will try again.

Having this is C would certainly be a lot better, but my comment was
merely to move this tiny bit of assembly somewhere else, but keep it as
assembly if it's really needed.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

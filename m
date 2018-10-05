From: Robert.Richter@cavium.com (Richter, Robert)
Date: Fri, 5 Oct 2018 15:15:14 +0000
Subject: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
In-Reply-To: <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
 <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
 <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
 <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
Message-ID: <20181005151505.GO3795@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.18 16:13:48, Matthias Brugger wrote:
> On 05/10/2018 15:42, Marc Zyngier wrote:
> > On 05/10/18 13:33, Matthias Brugger wrote:

> >> With my distribution head on, I would prefer a solution that does not change
> >> FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third solution to
> >> the same problem :)
> >
> > Why is that a problem? What impact does this have on your favourite distro?
> >
> 
> The impact is on changing FORCE_MAX_ZONEORDER on an already released kernel will
> break Kernel ABI and with that all external modules. I know that's nothing
> upstream cares too much about, but the distros do :)

Wrt upstream, there is no way to do this change without patching the
kernel. Thus, it is impossible to run an unpatched 4k page size kernel
on ThunderX.

-Robert

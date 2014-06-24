From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 17:01:08 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <alpine.LFD.2.11.1406241050390.16842@knanqh.ubzr>
References: <7416978.W29blLsymn@wuerfel>
 <20140624143503.GQ32514@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1406241050390.16842@knanqh.ubzr>
Message-ID: <4861343.lqFLZvsPzW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 10:56:44 Nicolas Pitre wrote:
> On Tue, 24 Jun 2014, Russell King - ARM Linux wrote:
> 
> > As I point out, the problem is that if we build a kernel with ARM926
> > plus Feroceon support (thus including some of the Feroceon platforms),
> > and omitting the plagerised ID, how do we stop the potential data
> > corruption occuring should we boot on a Feroceon platform with the
> > old IDs.
> 
> That's a valid concern.
> 
> I don't know if all the Feroceon CPU cores are buggy wrt the VFP, 
> however only some of the Orion5x platforms had a Feroceon core using the 
> plagerised ID.  Probably those two issues should be handled separately.
> 
> So for the later I'd simply forbid any Orion5x platforms from being part 
> of a multi-platform kernel.

We should definitely allow building a multiplatform kernel with both
Orion5x and Kirkwood, but we could make Orion5x conditional on ARM926
being disabled. Or we add a runtime-check in the Orion code to ensure
it only gets booted with the new CPU ID if ARM926 is enabled.

	Arnd

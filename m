From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 10:56:44 -0400 (EDT)
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624143503.GQ32514@n2100.arm.linux.org.uk>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
 <alpine.LFD.2.11.1406240956540.16842@knanqh.ubzr>
 <20140624141056.GD4489@arm.com>
 <20140624141423.GP32514@n2100.arm.linux.org.uk>
 <20140624142505.GF4489@arm.com>
 <20140624143503.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1406241050390.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Russell King - ARM Linux wrote:

> As I point out, the problem is that if we build a kernel with ARM926
> plus Feroceon support (thus including some of the Feroceon platforms),
> and omitting the plagerised ID, how do we stop the potential data
> corruption occuring should we boot on a Feroceon platform with the
> old IDs.

That's a valid concern.

I don't know if all the Feroceon CPU cores are buggy wrt the VFP, 
however only some of the Orion5x platforms had a Feroceon core using the 
plagerised ID.  Probably those two issues should be handled separately.

So for the later I'd simply forbid any Orion5x platforms from being part 
of a multi-platform kernel.


Nicolas

From: bhutchings@solarflare.com (Ben Hutchings)
Date: Sun, 24 Mar 2013 19:11:07 +0000
Subject: [PATCH] Fix IXP4xx coherent allocations
In-Reply-To: <20130323.195740.2108147521543354261.davem@davemloft.net>
References: <m3obe9lxil.fsf@intrepid.localdomain>
 <20130323.195740.2108147521543354261.davem@davemloft.net>
Message-ID: <1364152267.3620.31.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-03-23 at 19:57 -0400, David Miller wrote:
> From: Krzysztof Halasa <khc@pm.waw.pl>
> Date: Sat, 23 Mar 2013 20:35:46 +0100
> 
> > ARM core code currently requires coherent DMA mask to be set. Make sure
> > we limit PCI devices to 64 MiB while allowing on-chip devices to access
> > the whole 4 GiB address space.
> > 
> > This fixes a v3.7+ regression which broke IXP4xx built-in network devices.
> > 
> > Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
> 
> This requirement is not reasonable.
> 
> The DMA API documentation clearly states what the default must be,
> and what drivers are guarenteed will be the default.

I'm failing to see where it says the default can't be narrower than 32
bits due to platform limits.  And how do you think DMA mapping is
supposed to work for PCI devices on these platforms, anyway?

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

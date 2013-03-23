From: davem@davemloft.net (David Miller)
Date: Sat, 23 Mar 2013 19:57:40 -0400 (EDT)
Subject: [PATCH] Fix IXP4xx coherent allocations
In-Reply-To: <m3obe9lxil.fsf@intrepid.localdomain>
References: <m3obe9lxil.fsf@intrepid.localdomain>
Message-ID: <20130323.195740.2108147521543354261.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 23 Mar 2013 20:35:46 +0100

> ARM core code currently requires coherent DMA mask to be set. Make sure
> we limit PCI devices to 64 MiB while allowing on-chip devices to access
> the whole 4 GiB address space.
> 
> This fixes a v3.7+ regression which broke IXP4xx built-in network devices.
> 
> Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

This requirement is not reasonable.

The DMA API documentation clearly states what the default must be,
and what drivers are guarenteed will be the default.

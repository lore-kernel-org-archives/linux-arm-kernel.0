From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Fri, 27 Aug 2010 09:26:17 +0900
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <m3iq2x2wgp.fsf@intrepid.localdomain>
References: <1282254713.22370.368.camel@pasglop>
	<20100826205344E.fujita.tomonori@lab.ntt.co.jp>
	<m3iq2x2wgp.fsf@intrepid.localdomain>
Message-ID: <20100827092453A.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 18:02:46 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:
> 
> > Lots of drivers call dma_set_coherent_mask with 64bit mask and then
> > call it with 32bit mask if 64bit mask fails.
> 
> Which seems strange to me. If the driver asks for 64-bit mask and the
> system can only give it 32-bits, why return an error? Every 32-bit
> address is also 64-bit, with the most significant bits simply cleared.

As I wrote, the DMA API simply wasn't designed in that way (let
architectures to clip the mask), I guess.

If it was, dma_set_coherent_mask might return the actual mask.

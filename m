From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 30 Apr 2011 08:55:06 +1000
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <BANLkTinNMxpAcjpBR7r1f1RA31kww=v6Fw@mail.gmail.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop> <201104291326.25634.arnd@arndb.de>
	<4DBAA9B4.3070306@vmware.com>
	<BANLkTinNMxpAcjpBR7r1f1RA31kww=v6Fw@mail.gmail.com>
Message-ID: <1304117706.2513.269.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 09:34 -0400, Jerome Glisse wrote:
> 
> Radeon memory controller can do non snooped pci transaction, as far as
> i have tested most of the x86 pci bridge don't try to be coherent then
> ie they don't analyze pci dma and ask for cpu flush they just perform
> the request (and i guess it's what all bridge will do), so it endup
> being noncoherent. I haven't done any benchmark of how faster it's for
> the GPU when it's not snooping but i guess it can give 50% boost as it
> likely drastictly reduce pci transaction overhead.
> 
> I am talking here about device that you plug into any pci or pcie
> slot, so it's not igp integrated into northbridge or into the cpu.

Right, the card has nothing to do with the snooping process, it's purely
a feature of the bridge, based on a flag optionally set by the card. As
I said earlier, bridges have the freedom to ignore it, which we do on
ppc, so that's a non issue.

Cheers,
Ben.

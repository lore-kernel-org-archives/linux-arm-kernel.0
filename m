From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 May 2014 11:08:29 +0100
Subject: [PATCHv5 3/4] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400487234-4501-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400487234-4501-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400487234-4501-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140519100829.GE5113@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 09:13:53AM +0100, Thomas Petazzoni wrote:
> The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
> CPU core, the PL310 cache and the Marvell PCIe hardware block are
> affected a L2/PCIe deadlock caused by a system erratum when hardware
> I/O coherency is used.
> 
> This deadlock can be avoided by mapping the PCIe memory areas as
> strongly-ordered (note: MT_UNCACHED is strongly-ordered), and by
> removing the outer cache sync done in software. This is implemented in
> this patch by:
> 
>  * Registering a custom arch_ioremap_caller function that allows to
>    make sure PCI memory regions are mapped MT_UNCACHED.
> 
>  * Adding at runtime the 'arm,io-coherent' property to the PL310 cache
>    controller. This cannot be done permanently in the DT, because the
>    hardware I/O coherency can only be enabled when CONFIG_SMP is
>    enabled, in the current kernel situation.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

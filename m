From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 10:36:57 +0100
Subject: [PATCHv3 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140515093657.GG11117@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:18:39AM +0100, Thomas Petazzoni wrote:
> The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
> CPU core, the PL310 cache and the Marvell PCIe hardware block are
> affected a L2/PCIe deadlock caused by a system erratum when hardware
> I/O coherency is used.
> 
> This deadlock can be avoided by mapping the PCIe memory areas as
> strongly-ordered (note: MT_UNCACHED is strongly-ordered), and by
> removing the outer cache sync done in software. This is done in this
> patch, thanks to the new bits of infrastructure added in 'ARM: mm:
> allow sub-architectures to override PCI I/O memory type' and 'ARM: mm:
> add support for HW coherent systems in PL310' respectively.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

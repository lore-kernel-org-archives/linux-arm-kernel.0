From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Nov 2011 11:46:14 +0000
Subject: [PATCH v8 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <20111110225737.GX12913@n2100.arm.linux.org.uk>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-17-git-send-email-catalin.marinas@arm.com>
 <20111110225737.GX12913@n2100.arm.linux.org.uk>
Message-ID: <20111111114613.GF23243@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:57:37PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 04:16:58PM +0000, Catalin Marinas wrote:
> > +config ARCH_PHYS_ADDR_T_64BIT
> > +	def_bool ARM_LPAE
> > +
> > +config ARCH_DMA_ADDR_T_64BIT
> > +	def_bool ARM_LPAE
> > +
> 
> I still say this shouldn't depend on the host page table format.  LPAE
> itself has nothing to do with whether 64-bit DMA addresses are supported
> by the system.

So we could change this to:

config ARCH_DMA_ADDR_T_64BIT
	depends on ARM_LPAE

and let platforms select it.

The x86 approach is to have another HIGHMEM64G config option for
systems with more than 4GB of RAM and ARCH_DMA_ADDR_T_64BIT is selected
automatically. But this comes under the assumption that there is a 1:1
mapping between phys and bus addresses.

-- 
Catalin

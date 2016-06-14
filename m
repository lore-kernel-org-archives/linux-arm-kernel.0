From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jun 2016 17:41:16 +0100
Subject: [PATCH v3 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <02dde480-cc01-6372-5baa-02ecf0037074@linaro.org>
References: <20160527171424.GG10909@e104818-lin.cambridge.arm.com>
 <20160602174910.30428-1-aleksey.makarov@linaro.org>
 <02dde480-cc01-6372-5baa-02ecf0037074@linaro.org>
Message-ID: <20160614164116.GF16531@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 06:51:19PM +0300, Aleksey Makarov wrote:
> 
> On 06/02/2016 08:49 PM, Aleksey Makarov wrote:
> > From: Jon Masters <jcm@redhat.com>
> > 
> > This patch adds support for ACPI_TABLE_UPGRADE for ARM64
> 
> Hi Catalin, Will,
> 
> Can you review this v3 patch please?  I changed PFN_PHYS(max_pfn) to
> MEMBLOCK_ALLOC_ACCESSIBLE.

I'm inclined to agree with Mark that this is something that should be
done by the bootloader (e.g. GRUB) if it's needed, rather than something
we should support in the kernel. Jon pitched the feature as a developer
aid for triaging problems, so it's not like we're in a state where some
widely available machine cannot currently boot Linux without this.

Having said that, the patch isn't exactly invasive and I suspect it's
only a matter of time before we will actually want something like this.
So I've come full circle on this patch:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

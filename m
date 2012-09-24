From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 16:17:26 +0100
Subject: [PATCH v3 RESEND 14/17] ARM: LPAE: accomodate >32-bit
 addresses for page table base
In-Reply-To: <1348242975-19184-15-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-15-git-send-email-cyril@ti.com>
Message-ID: <20120924151726.GB14198@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:12PM +0100, Cyril Chemparathy wrote:
> This patch redefines the early boot time use of the R4 register to steal a few
> low order bits (ARCH_PGD_SHIFT bits) on LPAE systems.  This allows for up to
> 38-bit physical addresses.

That's fine. We figured out that on the vexpress with A15 and sparsemem
enabled could only use 36-bit because of section number stored in the
top bits of page->flags.

An alternative to this patch could be to always patch in the upper
32-bit of phys_offset like you do in virt_to_phys(). We know that pgd is
always lowmem.

-- 
Catalin

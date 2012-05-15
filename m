From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 13:22:36 +0100
Subject: [PATCH] ARM: LPAE: fix access flag setup in mem_type_table
In-Reply-To: <1337018189-27356-1-git-send-email-vitalya@ti.com>
References: <1337018189-27356-1-git-send-email-vitalya@ti.com>
Message-ID: <20120515122236.GL10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 01:56:29PM -0400, Vitaly Andrianov wrote:
> A zero value for prot_sect in the memory types table implies that
> section mappings should never be created for the memory type in question.
> This is checked for in alloc_init_section().
> 
> With LPAE, we set a bit to mask access flag faults for kernel mappings.
> This breaks the aforementioned (!prot_sect) check in alloc_init_section().
> 
> This patch fixes this bug by first checking for a non-zero
> prot_sect before setting the PMD_SECT_AF flag.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Same comments as for the previous patch.

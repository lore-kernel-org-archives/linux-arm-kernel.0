From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 May 2016 15:42:26 +0100
Subject: [PATCH v7 13/15] ACPI / processor: Add acpi_map_madt_entry().
In-Reply-To: <1464129345-18985-14-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
 <1464129345-18985-14-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160525144225.GF5996@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 03:35:43PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Follow-on arm64 ACPI/NUMA patches need to map MADT entries very early
> (before kmalloc is usable).
> 
> Add acpi_map_madt_entry() which, indirectly, uses
> early_memremap()/early_memunmap() to access the table and parse out
> the mpidr.  The existing implementation of map_madt_entry() is
> modified to take a pointer to the MADT as a parameter and the callers
> adjusted.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 16:43:54 +0000
Subject: [patch v11 03/23] ARM64: allow late use of early_ioremap
In-Reply-To: <1427205776-5060-4-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325164354.GB14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:36PM +0800, Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
> added a missing call to early_ioremap_reset(). This triggers a BUG if code
> tries using early_ioremap() after the early_ioremap_reset(). This is a
> problem for some ACPI code which needs short-lived temporary mappings
> after paging_init() but before acpi_early_init() in start_kernel(). This
> patch adds definitions for the __late_set_fixmap() and __late_clear_fixmap()
> which avoids the BUG by allowing later use of early_ioremap().
> 
> CC: Leif Lindholm <leif.lindholm@linaro.org>
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

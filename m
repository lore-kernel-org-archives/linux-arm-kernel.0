From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 16:50:04 +0000
Subject: [patch v11 05/23] ACPI: fix acpi_os_ioremap for arm64
In-Reply-To: <1427205776-5060-6-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325165004.GD14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:38PM +0800, Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

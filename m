From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 8 Feb 2016 13:00:44 -0600
Subject: [PATCHv9 3/4] ARM: socfpga: enable L2 cache ECC on startup
In-Reply-To: <1453911203-30202-3-git-send-email-tthayer@opensource.altera.com>
References: <1453911203-30202-1-git-send-email-tthayer@opensource.altera.com>
 <1453911203-30202-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <56B8E5DC.5090600@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/27/2016 10:13 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch enables the ECC for L2 cache on machine startup. The ECC has to
> be enabled before data is stored in memory otherwise the ECC will fail on
> reads.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v9: Improve node put handling.
> v8: Address community suggestions for strings. Fix string based on
>     maintainer feedback. Update year in header.
> v7: unmap locally scoped mapped_l2_edac_addr and add of_node_put(np)
> v6: Remove pr_debug() & update year in header.
> ---
>  arch/arm/mach-socfpga/Makefile   |    1 +
>  arch/arm/mach-socfpga/core.h     |    1 +
>  arch/arm/mach-socfpga/l2_cache.c |   41 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/socfpga.c  |    2 ++
>  4 files changed, 45 insertions(+)
>  create mode 100644 arch/arm/mach-socfpga/l2_cache.c
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

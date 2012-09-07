From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Sep 2012 09:25:57 -0600
Subject: [PATCH] ARM: tegra: Fix data type for io address
In-Reply-To: <1346996455-31697-1-git-send-email-pgaikwad@nvidia.com>
References: <1346996455-31697-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <504A1205.7090405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 11:40 PM, Prashant Gaikwad wrote:
> Warnings were generated because following commit changed data type for
> address pointer
> 
> 195bbca ARM: 7500/1: io: avoid writeback addressing modes for __raw_ accessors
> 
> arch/arm/mach-tegra/tegra30_clocks.c: In function 'clk_measure_input_freq':
> arch/arm/mach-tegra/tegra30_clocks.c:418:2: warning: passing argument 2 of '__raw_writel' makes pointer from integer without a cast
> .../arch/arm/include/asm/io.h:88:20: note: expected 'volatile void *' but argument is of type 'unsigned int
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

Thanks, applied to Tegra's for-3.7/common-clk branch.

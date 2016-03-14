From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Mar 2016 19:11:18 +0530
Subject: [PATCH 4/4] mmc: davinci: suppress waring when using DT
In-Reply-To: <1457567405-30475-5-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-5-git-send-email-david@lechnology.com>
Message-ID: <56E6BF7E.7020401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> When using device tree dms resources are not obtained via IORESOURCE_DMA.
> As a result, we would get warning even though DMA was working.
> 
> This fixes the problem by checking for dev.of_node and skipping trying to
> get the dma platform resource if we are using device tree.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Actually, with Peter's series adding dma_slave_map[] for all
mach-davinci platforms, this code should not be needed at all. Can you
try that dropping the platform_get_resource() calls for DMA works with
linux-next?

Thanks,
Sekhar

From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 12 Sep 2013 15:28:23 +0530
Subject: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <1378839171-14455-1-git-send-email-joelf@ti.com>
References: <1378839171-14455-1-git-send-email-joelf@ti.com>
Message-ID: <5231903F.7080301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 September 2013 12:22 AM, Joel Fernandes wrote:
> HWMOD removal for MMC is breaking edma_start as the events are being manually
> triggered due to unused channel list not being clear.
> 
> This patch fixes the issue, by reading the "dmas" property from the DT node if
> it exists and clearing the bits in the unused channel list. For this purpose
> we use the of_* helpers to parse the arguments in the dmas phandle list.
> 
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Reported-by: Balaji T K <balajitk@ti.com>
> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> This patch is a repost of v2 with minor change of return value.

Is this patch meant for merging? If yes, I see no resolution of the
comments given in this thread:

https://lkml.org/lkml/2013/7/30/9

It is better to send one version with all comments fixed. Helps avoid
confusion.

Thanks,
Sekhar

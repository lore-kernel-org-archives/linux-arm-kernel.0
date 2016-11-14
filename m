From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Mon, 14 Nov 2016 10:11:01 +0000
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161114101101.GK1575@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:17:48PM +0100, Sylwester Nawrocki wrote:
> This patch series aims to convert the s3c64xx platform to use
> the new DMA channel request API, i.e. this is only meaningful 
> for non-dt systems using s3c64xx SoCs.
> 
> Presumably the first 2 or 4 patches in this series could be queued 
> for v4.10-rc1 and the remaining patches could be left for subsequent
> release, to avoid non-trivial conflict with patches already applied 
> in the ASoC tree.
> 
> The whole series can be pulled from git repository:
>  git://linuxtv.org/snawrocki/samsung.git 
>  branch: for-v4.10/dma/pl080-s3c64xx-v2

Tested this series again still looks good to me. The code on that
branch does differ from the code on the list by the following
diff however:

--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2317,7 +2317,7 @@ static int pl08x_probe(struct amba_device
*adev, const struct amba_id *id)
       } else {
            pl08x->slave.filter.map = pl08x->pd->slave_map;
            pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
-           pl08x->slave.filter.fn = pl08x_filter_id;
+           pl08x->slave.filter.fn = pl08x_filter_fn;
       }

I tested the code from the list, rather than the branch.

Thanks,
Charles

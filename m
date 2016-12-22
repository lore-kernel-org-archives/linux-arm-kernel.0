From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 22 Dec 2016 14:22:06 +0800
Subject: [PATCH 3/3] dma: zx: fix residue calculation
In-Reply-To: <1481810617-7650-3-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
 <1481810617-7650-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CABymUCMM=9TS_r5NE417NZtjV6KYw4pG=9gjeOTnA0gTZDQkfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-15 22:03 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> The dma residue is defined as the free space to end of transfer buffer,
> which could be multiple segments chained together.  So the residue
> calculation in zx_dma_tx_status() works for both slave_sg and cyclic
> case.  But unfortunately, the 'index' is wrong.  It should plus one,
> because the current segment is already occupied and shouldn't be counted
> into free space.
>
> This fixes the HDMI audio noise issue we see on ZX296718 with SPDIF
> interface.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/zx_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by:  Jun Nie <jun.nie@linaro.org>

From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 12 Oct 2011 13:01:48 +0900
Subject: [PATCH v6 02/10] DMA: PL330: Infer transfer direction from
	transfer request instead of platform data
In-Reply-To: <1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <000901cc8893$aa37b790$fea726b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:

> Sent: Tuesday, October 11, 2011 3:16 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com;
> vinod.koul at intel.com; Jassi Brar; Boojin Kim
> Subject: [PATCH v6 02/10] DMA: PL330: Infer transfer direction from
> transfer request instead of platform data
>
> The transfer direction for a channel can be inferred from the transfer
> request and the need for specifying transfer direction in platfrom
> data
> can be eliminated. So the structure definition 'struct dma_pl330_peri'
> is no longer required.
>
> The channel's private data is set to point to a channel id specified
> in
> the platform data (instead of an instance of type 'struct
> dma_pl330_peri').
> The filter function is correspondingly modified to match the channel
> id.
>
> With the 'struct dma_pl330_peri' removed from platform data, the dma
> controller transfer capabilities cannot be inferred any more. Hence,
> the dma controller capabilities is specified using platform data.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/dma/pl330.c        |   65 +++++++++++---------------------------
> ------
>  include/linux/amba/pl330.h |   13 ++-------
>  2 files changed, 19 insertions(+), 59 deletions(-)
>

Looks good to me.
Acked-by: Boojin Kim <boojin.kim@samsung.com>

From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 26 Aug 2011 20:55:56 +0530
Subject: [PATCH v7 04/15] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <1314238425-6480-5-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
	<1314238425-6480-5-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY2MtoxQfaXZs49161zAxuNyS7xXdMa9MNj6LZt03gK0Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 7:43 AM, Boojin Kim <boojin.kim@samsung.com> wrote:

> ?static void pl330_issue_pending(struct dma_chan *chan)
> ?{
> - ? ? ? pl330_tasklet((unsigned long) to_pchan(chan));
> + ? ? ? struct dma_pl330_chan *pch = to_pchan(chan);
> +
> + ? ? ? pl330_tasklet((unsigned long) pch);
> ?}
This is a useless churn since v6.

Please fix this and add
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

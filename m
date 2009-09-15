From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:07:51 +0100
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
In-Reply-To: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
References: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915100751.GC22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:22PM +0900, Jassi wrote:

> +#if 0
>  		if (chan->flags & S3C2410_DMAF_CIRCULAR) {
>  			struct s3c64xx_dma_buff *curr = chan->curr;
>  			lli->next_lli = curr->lli_dma;
>  		}
> +#endif

If you're doing something like this you should remove the code rather
than if 0 it out, or at least insert a comment explaining why the code
is sitting around.  Though I'm a bit concerned that if something has
actually tried to set up circular DMA it might get upset if that's
ignored (not that I've looked in detail).

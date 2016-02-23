From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 23 Feb 2016 18:45:09 +0100
Subject: [PATCH v2 2/4] dmaengine: mmp-pdma: add number of requestors
In-Reply-To: <1455569868-25017-2-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 15 Feb 2016 21:57:46 +0100")
References: <1455569868-25017-1-git-send-email-robert.jarzmik@free.fr>
 <1455569868-25017-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <8737sjwcbe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The DMA chip has a fixed number of requestor lines used for flow
> control. This number is platform dependent. The pxa_dma dma driver will
> use this value to activate or not the flow control.
>
> There won't be any impact on mmp_pdma driver.
Haojian,

Even if mmp_pdma will not be impacted, it would be good to have have your ack on
this trivial patch.

Cheers.

--
Robert

[1] The patch
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  include/linux/platform_data/mmp_dma.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
> index 2a330ec9e2af..d1397c8ed94e 100644
> --- a/include/linux/platform_data/mmp_dma.h
> +++ b/include/linux/platform_data/mmp_dma.h
> @@ -14,6 +14,7 @@
>  
>  struct mmp_dma_platdata {
>  	int dma_channels;
> +	int nb_requestors;
>  };
>  
>  #endif /* MMP_DMA_H */

-- 
Robert

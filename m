From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 3 Sep 2018 14:15:07 +0200
Subject: [PATCH 03/14] mmc: mmci: internalize dma_inprogress into mmci dma
 functions
In-Reply-To: <1533116221-380-4-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
 <1533116221-380-4-git-send-email-ludovic.Barre@st.com>
Message-ID: <CAPDyKFoWPcWmjgivNVUeLR6j-_KUY-O-aJfgdh3dhQKL3oPedQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the dma_inprogress into mmci dma interfaces.
> This allows to simplify and prepare the next dma callbacks
> for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
> and mmci_dma_finalize.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

[...]

> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 696a066..f1ec066 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,9 +332,7 @@ struct mmci_host {
>         struct mmci_host_next   next_data;
>         bool                    dma_in_progress;
>
> -#define dma_inprogress(host)   ((host)->dma_in_progress)
> -#else
> -#define dma_inprogress(host)   (0)
> +#define __dma_inprogress(host) ((host)->dma_in_progress)

Please keep the existing function name.

If there are good reasons to change it, please make it a part of a
change where it makes sense.

>  #endif
>  };
>
> --
> 2.7.4
>

Besides the nitpick above, this looks good to me!

Kind regards
Uffe

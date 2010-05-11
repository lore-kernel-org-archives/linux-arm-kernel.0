From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 11 May 2010 09:37:42 -0700
Subject: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH 901
	318 v6
In-Reply-To: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 5:54 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the DMA engine driver for the COH 901 318 used in the
> U300 platform with the generic PrimeCell interface.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?drivers/dma/coh901318.c | ?146 +++++++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 146 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> index 4233440..1d5ed16 100644
> --- a/drivers/dma/coh901318.c
> +++ b/drivers/dma/coh901318.c
[..]
> +void dma_set_ambaconfig(struct dma_chan *chan,
> + ? ? ? ? ? ? ? ? ? ? ? struct amba_dma_channel_config *config)

What happens when two primecell dma devices are present on one soc?
Can that happen?  In that case we'll have conflicting providers of
dma_set_ambaconfig().

--
Dan

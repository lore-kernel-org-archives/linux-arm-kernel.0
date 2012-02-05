From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 5 Feb 2012 19:53:31 +0800
Subject: [PATCH resent v2 1/2] ioport : add DEFINE_RES_DMA_SIZE_NAMED macro
In-Reply-To: <1326959620-25920-2-git-send-email-b32955@freescale.com>
References: <1326959620-25920-1-git-send-email-b32955@freescale.com>
 <1326959620-25920-2-git-send-email-b32955@freescale.com>
Message-ID: <CAMiH66FoX0m_NPntMRyt6zJoYgxuYnzv6neDggmKxW8nfzKJiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does any one have any comments about this patch?

thanks.

On Thu, Jan 19, 2012 at 3:53 PM, Huang Shijie <b32955@freescale.com> wrote:
> Some DMA resource does have the range more then ones.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
> ?include/linux/ioport.h | ? ?4 +++-
> ?1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 9d57a71..9ea5de4 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -134,8 +134,10 @@ struct resource_list {
> ?#define DEFINE_RES_IRQ(_irq) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ?DEFINE_RES_IRQ_NAMED((_irq), NULL)
>
> +#define DEFINE_RES_DMA_SIZE_NAMED(_dma, _size, _name) ? ? ? ? ? ? ? ? ?\
> + ? ? ? DEFINE_RES_NAMED((_dma), (_size), (_name), IORESOURCE_DMA)
> ?#define DEFINE_RES_DMA_NAMED(_dma, _name) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> - ? ? ? DEFINE_RES_NAMED((_dma), 1, (_name), IORESOURCE_DMA)
> + ? ? ? DEFINE_RES_DMA_SIZE_NAMED((_dma), 1, (_name))
> ?#define DEFINE_RES_DMA(_dma) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> ? ? ? ?DEFINE_RES_DMA_NAMED((_dma), NULL)
>
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/

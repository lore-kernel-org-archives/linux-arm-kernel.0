From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 29 Dec 2014 09:53:12 +0200
Subject: [PATCH] arch: arm: common: edma.c:  Remove some unused functions
In-Reply-To: <1417906406-5527-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1417906406-5527-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <54A10868.70001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2014 12:53 AM, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> edma_shadow0_read() edma_or_array()
> 
> This was partially found by using a static code analysis program called cppcheck.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  arch/arm/common/edma.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index d86771a..163273d 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -160,10 +160,6 @@ static inline void edma_modify_array(unsigned ctlr, int offset, int i,
>  {
>  	edma_modify(ctlr, offset + (i << 2), and, or);
>  }
> -static inline void edma_or_array(unsigned ctlr, int offset, int i, unsigned or)
> -{
> -	edma_or(ctlr, offset + (i << 2), or);
> -}
>  static inline void edma_or_array2(unsigned ctlr, int offset, int i, int j,
>  		unsigned or)
>  {
> @@ -174,10 +170,6 @@ static inline void edma_write_array2(unsigned ctlr, int offset, int i, int j,
>  {
>  	edma_write(ctlr, offset + ((i*2 + j) << 2), val);
>  }
> -static inline unsigned int edma_shadow0_read(unsigned ctlr, int offset)
> -{
> -	return edma_read(ctlr, EDMA_SHADOW0 + offset);
> -}
>  static inline unsigned int edma_shadow0_read_array(unsigned ctlr, int offset,
>  		int i)
>  {
> 


-- 
P?ter

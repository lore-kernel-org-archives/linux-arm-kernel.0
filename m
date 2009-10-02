From: sedji.gaouaou@atmel.com (Sedji Gaouaou)
Date: Fri, 02 Oct 2009 16:08:34 +0200
Subject: [PATCH] at91: enable ssc reception on at91sam9g20ek
In-Reply-To: <1254387002-22105-1-git-send-email-sedji.gaouaou@atmel.com>
References: <1254387002-22105-1-git-send-email-sedji.gaouaou@atmel.com>
Message-ID: <4AC60962.3090608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch was actually more a tips and tricks than a proper patch.
Indeed there is currently no Mic entry on the at91sam9g20ek board, but 
it could be quite easy to add one.
For instance


More informations could be found here: 
http://www.linux4sam.org/twiki/bin/view/Linux4SAM/AudioRecordOnAt91sam9g20ek


Regards,
Sedji

Sedji Gaouaou a ?crit :
> This patch enables reception in the ssc driver and therefore adds recording capabilities for the ATMEL AT91SAM9G20EK board.
> (patch based on: http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git).
> ---
>  arch/arm/mach-at91/board-sam9g20ek.c |    2 +-
>  sound/soc/atmel/atmel_ssc_dai.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index a55398e..f74cefc 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -302,7 +302,7 @@ static void __init ek_board_init(void)
>  	/* PCK0 provides MCLK to the WM8731 */
>  	at91_set_B_periph(AT91_PIN_PC1, 0);
>  	/* SSC (for WM8731) */
> -	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX);
> +	at91_add_device_ssc(AT91SAM9260_ID_SSC, ATMEL_SSC_TX | ATMEL_SSC_RX);
>  }
>  
>  MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index e588e63..7e78e02 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -427,7 +427,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  			| SSC_BF(RCMR_STTDLY, START_DELAY)
>  			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
>  			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
> -			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
> +			| SSC_BF(RCMR_CKO, SSC_CKO_CONTINUOUS)
>  			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
>  
>  		rfmr =	  SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)

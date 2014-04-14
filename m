From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 15 Apr 2014 00:51:29 +0200
Subject: [PATCH 2/4] ALSA: sound/atmel-ac97c.h: Remove unused flags from
 platform data
In-Reply-To: <1397293707-26890-3-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <1397293707-26890-3-git-send-email-alexanders83@web.de>
Message-ID: <20140414225129.GZ2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2014 at 11:08:25 +0200, Alexander Stein wrote :
> This platform data member is unsed, so remove it.
                                 ^
                                 another typo :)
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>
I would say that it doesn't matter anymore but no code is better tahn
dead code.

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  include/sound/atmel-ac97c.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/sound/atmel-ac97c.h b/include/sound/atmel-ac97c.h
> index e6aabdb..00e6c289 100644
> --- a/include/sound/atmel-ac97c.h
> +++ b/include/sound/atmel-ac97c.h
> @@ -23,7 +23,6 @@
>   * @reset_pin: GPIO pin wired to the reset input on the external AC97 codec,
>   *             optional to use, set to -ENODEV if not in use. AC97 layer will
>   *             try to do a software reset of the external codec anyway.
> - * @flags: Flags for which directions should be enabled.
>   *
>   * If the user do not want to use a DMA channel for playback or capture, i.e.
>   * only one feature is required on the board. The slave for playback or capture
> @@ -33,7 +32,6 @@
>  struct ac97c_platform_data {
>  	struct dw_dma_slave	rx_dws;
>  	struct dw_dma_slave	tx_dws;
> -	unsigned int 		flags;
>  	int			reset_pin;
>  };
>  
> -- 
> 1.9.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

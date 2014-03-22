From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 22 Mar 2014 12:39:16 +0000
Subject: [PATCH v2 12/15] ARM: at91: remove atmel_tsadcc platform_data
In-Reply-To: <1395064628-644-13-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395064628-644-13-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532D8474.8020601@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/14 13:57, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
See below.
> ---
>   arch/arm/mach-at91/board.h          | 3 ---
>   include/linux/platform_data/atmel.h | 7 -------
>   2 files changed, 10 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board.h b/arch/arm/mach-at91/board.h
> index 6c08b341167d..4e773b55bc2d 100644
> --- a/arch/arm/mach-at91/board.h
> +++ b/arch/arm/mach-at91/board.h
> @@ -118,9 +118,6 @@ struct isi_platform_data;
>   extern void __init at91_add_device_isi(struct isi_platform_data *data,
>   		bool use_pck_as_mck);
>
> - /* Touchscreen Controller */
> -extern void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data);
> -
>   /* CAN */
>   extern void __init at91_add_device_can(struct at91_can_data *data);
>
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index cea9f70133c5..4b452c6a2f7b 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -86,13 +86,6 @@ struct atmel_uart_data {
>   	struct serial_rs485	rs485;		/* rs485 settings */
>   };
>
> - /* Touchscreen Controller */
> -struct at91_tsadcc_data {
> -	unsigned int    adc_clock;
> -	u8		pendet_debounce;
> -	u8		ts_sample_hold_time;
> -};
> -
I believe this is still in use in the driver you don't remove until patch 14.

Probably best to reorder the patches...
>   /* CAN */
>   struct at91_can_data {
>   	void (*transceiver_switch)(int on);
>

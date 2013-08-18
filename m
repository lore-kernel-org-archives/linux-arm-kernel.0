From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Aug 2013 05:17:21 +0900
Subject: [PATCH RESEND] ARM: plat-samsung: Fix switching FIFO in
 arch_enable_uart_fifo function
In-Reply-To: <1372792593-7457-1-git-send-email-shc_work@mail.ru>
References: <1372792593-7457-1-git-send-email-shc_work@mail.ru>
Message-ID: <52112BD1.6090505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/13 04:16, Alexander Shiyan wrote:
> When CONFIG_S3C_BOOT_UART_FORCE_FIFO symbol is set, we should
> enable FIFO but actually switch command is missing in the code.
> This patch adds this switching.
>
> Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> ---
>   arch/arm/plat-samsung/include/plat/uncompress.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
> index 4afc32f..f48dc0a 100644
> --- a/arch/arm/plat-samsung/include/plat/uncompress.h
> +++ b/arch/arm/plat-samsung/include/plat/uncompress.h
> @@ -145,6 +145,8 @@ static inline void arch_enable_uart_fifo(void)
>   			if (!(fifocon&  S3C2410_UFCON_RESETBOTH))
>   				break;
>   		}
> +
> +		uart_wr(S3C2410_UFCON, S3C2410_UFCON_FIFOMODE);
>   	}
>   }
>   #else

Sorry for late response, applied.

Thanks,
Kukjin

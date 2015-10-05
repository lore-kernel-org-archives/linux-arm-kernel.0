From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Oct 2015 14:21:33 +0200
Subject: [PATCH] soc: Fix for clean up pmic driver - trivial
In-Reply-To: <20151005114444.GA11494@jci-VirtualBox>
References: <20151005114444.GA11494@jci-VirtualBox>
Message-ID: <19210837.P9sIqrRUPt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 October 2015 11:45:08 Mutharaju, Prasanna wrote:
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index f432291..628a919 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -35,8 +35,8 @@
>  #define PWRAP_GET_WACS_RDATA(x)                (((x) >> 0) & 0x0000ffff)
>  #define PWRAP_GET_WACS_FSM(x)          (((x) >> 16) & 0x00000007)
>  #define PWRAP_GET_WACS_REQ(x)          (((x) >> 19) & 0x00000001)
> -#define PWRAP_STATE_SYNC_IDLE0         (1 << 20)
> -#define PWRAP_STATE_INIT_DONE0         (1 << 21)
> +#define PWRAP_STATE_SYNC_IDLE0         BIT(20)
> +#define PWRAP_STATE_INIT_DONE0         BIT(21)
>  
>  /* macro for WACS FSM */
>  #define PWRAP_WACS_FSM_IDLE            0x00
> @@ -52,7 +52,7 @@
>  #define PWRAP_DEW_WRITE_TEST_VAL       0xa55a
>  
>  /* macro for manual command */
> -#define PWRAP_MAN_CMD_SPI_WRITE                (1 << 13)
> +#define PWRAP_MAN_CMD_SPI_WRITE                BIT(13)
>  #define PWRAP_MAN_CMD_OP_CSH           (0x0 << 8)
>  #define PWRAP_MAN_CMD_OP_CSL           (0x1 << 8)
>  #define PWRAP_MAN_CMD_OP_CK            (0x2 << 8)

I'd say the original version is clearer because of the context that
does not use (and should not) use BIT().

	Arnd

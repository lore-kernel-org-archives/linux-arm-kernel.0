From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Nov 2015 19:25:02 +0100
Subject: [PATCH 03/13] net: mvneta: fix bit assignment in
 MVNETA_RXQ_CONFIG_REG
In-Reply-To: <1448178839-3541-4-git-send-email-mw@semihalf.com> (Marcin
 Wojtas's message of "Sun, 22 Nov 2015 08:53:49 +0100")
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-4-git-send-email-mw@semihalf.com>
Message-ID: <87oaei7x8h.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On dim., nov. 22 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> MVNETA_RXQ_HW_BUF_ALLOC bit which controls enabling hardware buffer
> allocation was mistakenly set as BIT(1). This commit fixes the
> assignment.

I confirm it from the datasheet I got:

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v3.8+
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0f30aaa..d12b8c6 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -36,7 +36,7 @@
>  
>  /* Registers */
>  #define MVNETA_RXQ_CONFIG_REG(q)                (0x1400 + ((q) << 2))
> -#define      MVNETA_RXQ_HW_BUF_ALLOC            BIT(1)
> +#define      MVNETA_RXQ_HW_BUF_ALLOC            BIT(0)
>  #define      MVNETA_RXQ_PKT_OFFSET_ALL_MASK     (0xf    << 8)
>  #define      MVNETA_RXQ_PKT_OFFSET_MASK(offs)   ((offs) << 8)
>  #define MVNETA_RXQ_THRESHOLD_REG(q)             (0x14c0 + ((q) << 2))
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

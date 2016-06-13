From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2016 10:28:24 +0100
Subject: [PATCH 3/3] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465797329-22537-3-git-send-email-andrew.smirnov@gmail.com>
References: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
 <1465797329-22537-3-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20160613092824.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 10:55:29PM -0700, Andrey Smirnov wrote:
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> RESEND, now with Russell King on CC list.
> 
>  arch/arm/include/asm/hardware/cache-l2x0.h | 7 +++++++
>  arch/arm/mach-imx/system.c                 | 5 ++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 3a5ec1c..5e27162 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -61,6 +61,13 @@
>  #define L2X0_LINE_TAG			0xF30
>  #define L2X0_DEBUG_CTRL			0xF40
>  #define L310_PREFETCH_CTRL		0xF60
> +#define   L310_DOUBLE_LINEFILL_EN			BIT(30)
> +#define   L310_INSTRUCTION_PREFETCH_EN			BIT(29)
> +#define   L310_DATA_PREFETCH_EN				BIT(28)
> +#define   L310_DOUBLE_LINEFILL_ON_WRAP_READ_DIS		BIT(27)
> +#define   L310_PREFETCH_DROP_EN				BIT(24)
> +#define   L310_INCR_DOUBLE_LINEFILL_EN			BIT(23)
> +#define   L310_ESCLUSIVE_SEQUENCE_EN			BIT(21)

Looks like a spelling error... surely this should be EXCLUSIVE ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

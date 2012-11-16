From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Fri, 16 Nov 2012 14:25:31 +0100
Subject: ARM: imx: ehci-imx35: fix host power mask bit
In-Reply-To: <1353063197.3647.27.camel@mars>
References: <1353063197.3647.27.camel@mars>
Message-ID: <20121116142531.228251f6@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

Le Fri, 16 Nov 2012 11:53:17 +0100,
Christoph Fritz <chf.fritz@googlemail.com> a ?crit :

> This patch sets HPM (Host power mask bit) to bit 16 according to i.MX35
> Reference Manual. Falsely it was set to bit 8, but this controls pull-up
> Impedance.
> 
> Reported-by: Michael Burkey <mdburkey@gmail.com>
> Cc: Stable <stable@vger.kernel.org>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Acked-by: Eric B?nard <eric@eukrea.com>
the same problem exists in arch/arm/mach-imx/ehci-imx25.c may you
please also fix it in your patch at the same time ?

Thanks
Eric

> ---
>  arch/arm/mach-imx/ehci-imx35.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/ehci-imx35.c b/arch/arm/mach-imx/ehci-imx35.c
> index a596f70..554e7cc 100644
> --- a/arch/arm/mach-imx/ehci-imx35.c
> +++ b/arch/arm/mach-imx/ehci-imx35.c
> @@ -30,7 +30,7 @@
>  #define MX35_H1_SIC_SHIFT	21
>  #define MX35_H1_SIC_MASK	(0x3 << MX35_H1_SIC_SHIFT)
>  #define MX35_H1_PP_BIT		(1 << 18)
> -#define MX35_H1_PM_BIT		(1 << 8)
> +#define MX35_H1_PM_BIT		(1 << 16)
>  #define MX35_H1_IPPUE_UP_BIT	(1 << 7)
>  #define MX35_H1_IPPUE_DOWN_BIT	(1 << 6)
>  #define MX35_H1_TLL_BIT		(1 << 5)

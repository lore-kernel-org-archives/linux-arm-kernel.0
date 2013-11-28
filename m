From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 28 Nov 2013 13:44:16 +0100
Subject: [PATCH 03/10] ARM: imx6q: select ARM and PL310 errata
In-Reply-To: <1351005779-30347-4-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <52973AA0.4020802@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.10.2012 17:22, Shawn Guo wrote:
> ARM core r2p10 and PL310 r3p2 are integrated on imx6q.  Select
> corresponding errata.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>   arch/arm/mach-imx/Kconfig |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 4f73866..3ce2771 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
...
> @@ -843,6 +848,9 @@ config SOC_IMX6Q
>   	select MFD_SYSCON
>   	select PINCTRL
>   	select PINCTRL_IMX6Q
> +	select PL310_ERRATA_588369 if CACHE_PL310
> +	select PL310_ERRATA_727915 if CACHE_PL310
> +	select PL310_ERRATA_769419 if CACHE_PL310
>   	select PM_OPP if PM

Just a question: To my understanding, the PL310 on i.MX6D/Q is 
r3p1-50rel0 and on i.MX6DL/SOLO/SL is r3p2.

The PL310 errata I've (Document Revision: 12.1, 14-Apr-2011) states that 
588369 and 727915 don't apply to the PL310 revisions r3p1-50rel0/r3p2. 
So I would think that we don't have to select them for SOC_IMX6Q.

Have I missed anything?

Best regards

Dirk

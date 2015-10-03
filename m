From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:41:39 +0200
Subject: [PATCH v4 14/26] ARM: pxa: magician: Fix platform data for both
 PXA27x I2C controllers
In-Reply-To: <5609B243.9020306@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B243.9020306@tul.cz>
Message-ID: <1443876099.4186.28.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:33 +0200 schrieb Petr Cvek:
> This patch changes fast_mode settings for the normal and power I2C
> controller on the HTC Magician machine.
> 
> Connected device on the Power I2C:
> - MAX1587A: working in the fast mode
> 
> Connected devices on the Normal I2C:
> - UDA1380: working in the fast mode
> - OV9640: bus became stuck in the fast mode
> 
> The OV9640 is not using a standard I2C protocol, but an SCCB variant.
> Maybe
> it is not fully compatible in the fast mode. Therefore fast mode for
> normal
> I2C is disabled. If you not using the OV9640 then you can enable the
> fast
> mode for the UDA1380.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
> -pxa/magician.c
> index 906df6d..86d395d 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -818,7 +818,16 @@ static struct platform_device strataflash = {
>   */
>  
>  static struct i2c_pxa_platform_data i2c_info = {
> -	.fast_mode = 1,
> +	/* FIXME both I2C devices should support fast mode */

Maybe add the info from the commit description here (it's OV9640 that
doesn't support fast mode).

Otherwise,
Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp

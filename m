From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 3 May 2013 08:12:07 +0200
Subject: [PATCH] ARM: imx: fix typo in gpu3d_shader_sels
In-Reply-To: <1367549979-31291-1-git-send-email-shawn.guo@linaro.org>
References: <1367549979-31291-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51835537.7040604@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.05.2013 04:59, Shawn Guo wrote:
> There is no clock pll2_pfd9_720m.  Instead it should be pll3_pfd0_720m.
> Fix the typo in gpu3d_shader_sels.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>   arch/arm/mach-imx/clk-imx6q.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index f2e1c62..dda9a2b 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -186,7 +186,7 @@ static const char *audio_sels[]	= { "pll4_post_div", "pll3_pfd2_508m", "pll3_pfd
>   static const char *gpu_axi_sels[]	= { "axi", "ahb", };
>   static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
>   static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
> -static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd9_720m", };
> +static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll3_pfd0_720m", };
>   static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
>   static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_usb_otg", };
>   static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk

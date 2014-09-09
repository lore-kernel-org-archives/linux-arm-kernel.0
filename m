From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Tue, 09 Sep 2014 14:24:23 +0200
Subject: [PATCH] clk: samsung: exynos3250: fix mout_cam_blk parent list
In-Reply-To: <1410008613-20861-1-git-send-email-pankaj.dubey@samsung.com>
References: <1410008613-20861-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <540EF177.8090005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2014 15:03, Pankaj Dubey wrote:
> As per user manual of Exynos3250 SRC_CAM can select
> div_cam_blk_320 if it's value is 0xC, so placing
> div_cam_blk_320 at proper index in parent list of mout_cam_blk.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos3250.c |    1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>
> diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
> index e1cb464..ba8f073f 100644
> --- a/drivers/clk/samsung/clk-exynos3250.c
> +++ b/drivers/clk/samsung/clk-exynos3250.c
> @@ -248,6 +248,7 @@ PNAME(group_sclk_cam_blk_p)	= { "xxti", "xusbxti",
>   				    "none", "none", "none",
>   				    "none", "div_mpll_pre",
>   				    "mout_epll_user", "mout_vpll",
> +				    "none", "none", "none",
>   				    "div_cam_blk_320", };
>   PNAME(group_sclk_fimd0_p)	= { "xxti", "xusbxti",
>   				    "m_bitclkhsdiv4_2l", "none",
>

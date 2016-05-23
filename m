From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 23 May 2016 17:43:02 +0800
Subject: [RFC v2 3/5] drm/mediatek: add *driver_data for different
 hardware settings
In-Reply-To: <1463756736-46573-4-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
 <1463756736-46573-4-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463996582.30093.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

One comment below.

On Fri, 2016-05-20 at 23:05 +0800, yt.shen at mediatek.com wrote:
> From: YT Shen <yt.shen@mediatek.com>
> 
> There are some hardware settings changed, between MT8173 & MT2701:
> DISP_OVL address offset changed, color format definition changed.
> DISP_RDMA fifo size changed.
> DISP_COLOR offset changed.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
> +
> +static inline struct mtk_ddp_comp_driver_data *mtk_ovl_get_driver_data(
> +	struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =
> +		of_match_device(mtk_disp_ovl_driver_dt_match, &pdev->dev);
> +
> +	return (struct mtk_ddp_comp_driver_data *)of_id->data;
> +}
> +
> +static inline struct mtk_ddp_comp_driver_data *mtk_rdma_get_driver_data(
> +	struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =
> +		of_match_device(mtk_disp_rdma_driver_dt_match, &pdev->dev);
> +
> +	return (struct mtk_ddp_comp_driver_data *)of_id->data;
> +}
> +
> +static inline struct mtk_ddp_comp_driver_data *mtk_color_get_driver_data(
> +	struct device_node *node)
> +{
> +	const struct of_device_id *of_id =
> +		of_match_node(mtk_disp_color_driver_dt_match, node);
> +
> +	return (struct mtk_ddp_comp_driver_data *)of_id->data;
> +}
> + 

These three functions looks the same with different parameter:
mtk_disp_ovl_driver_dt_match, mtk_disp_rdma_driver_dt_match, and
mtk_disp_color_driver_dt_match. So merge them to prevent duplicated
code.

Regards,
CK

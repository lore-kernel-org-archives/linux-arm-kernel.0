From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 11 Apr 2016 10:52:33 +0800
Subject: [PATCH 1/2] drm/rockchip: remove redundant statement
In-Reply-To: <1459864232-25033-1-git-send-email-john@metanate.com>
References: <1459864232-25033-1-git-send-email-john@metanate.com>
Message-ID: <570B1171.7040402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?04?05? 21:50, John Keeping wrote:
> The call to arm_iommu_detach_device() on the previous line sets
> dev->archdata.mapping to NULL so this call is always a no-op.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f556a8f..7695c79 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -244,7 +244,6 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
>   	drm_kms_helper_poll_fini(drm_dev);
>   	component_unbind_all(dev, drm_dev);
>   	arm_iommu_detach_device(dev);
> -	arm_iommu_release_mapping(dev->archdata.mapping);
>   	drm_mode_config_cleanup(drm_dev);
>   	drm_dev->dev_private = NULL;
>   
Applied to my drm-fixes

Thanks.:-)

-- 
?ark Yao

From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 6 Sep 2016 15:26:10 +0800
Subject: [PATCH v7 2/9] drm/mediatek: add *driver_data for different
 hardware settings
In-Reply-To: <1472815484-43821-3-git-send-email-yt.shen@mediatek.com>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473146770.11736.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> There are some hardware settings changed, between MT8173 & MT2701:
> DISP_OVL address offset changed, color format definition changed.
> DISP_RDMA fifo size changed.
> DISP_COLOR offset changed.
> MIPI_TX pll setting changed.
> And add prefix for mtk_ddp_main & mtk_ddp_ext & mutex_mod.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---

[snip...]

>  
> @@ -185,7 +183,8 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
>  	writel_relaxed(pitch, comp->regs + DISP_REG_OVL_PITCH(idx));
>  	writel_relaxed(src_size, comp->regs + DISP_REG_OVL_SRC_SIZE(idx));
>  	writel_relaxed(offset, comp->regs + DISP_REG_OVL_OFFSET(idx));
> -	writel_relaxed(addr, comp->regs + DISP_REG_OVL_ADDR(idx));

DISP_REG_OVL_ADDR() is useless, so remove it.

> +	writel_relaxed(addr, comp->regs + comp->data->ovl.addr_offset
> +					+ idx * 0x20);
>  
>  	if (pending->enable)
>  		mtk_ovl_layer_on(comp, idx);


Regards,
CK

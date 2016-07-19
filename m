From: seanpaul@google.com (Sean Paul)
Date: Tue, 19 Jul 2016 16:38:15 -0400
Subject: [PATCH -next] drm/rockchip: analogix_dp: add missing
 clk_disable_unprepare() on error
In-Reply-To: <1468927963-2947-1-git-send-email-weiyj_lk@163.com>
References: <1468927963-2947-1-git-send-email-weiyj_lk@163.com>
Message-ID: <CAOw6vbKT--+A=wFdx2=PT7FCYga-ArDSrw4ypFDmqqaiitHyPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 7:32 AM, Wei Yongjun <weiyj_lk@163.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Add the missing clk_disable_unprepare() before return in the
> error handling case.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>


Applied to drm-misc



> ---
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index e81e19a..89aadbf 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -96,6 +96,7 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
>         ret = rockchip_dp_pre_init(dp);
>         if (ret < 0) {
>                 dev_err(dp->dev, "failed to dp pre init %d\n", ret);
> +               clk_disable_unprepare(dp->pclk);
>                 return ret;
>         }
>
> @@ -272,6 +273,7 @@ static int rockchip_dp_init(struct rockchip_dp_device *dp)
>         ret = rockchip_dp_pre_init(dp);
>         if (ret < 0) {
>                 dev_err(dp->dev, "failed to pre init %d\n", ret);
> +               clk_disable_unprepare(dp->pclk);
>                 return ret;
>         }
>
>

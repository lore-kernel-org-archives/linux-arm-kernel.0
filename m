From: rahul.sharma@samsung.com (RAHUL SHARMA)
Date: Thu, 04 Oct 2012 07:39:33 +0000 (GMT)
Subject: [PATCH v1 01/14] media: s5p-hdmi: add HPD GPIO to platform data
Message-ID: <8952601.531301349336373038.JavaMail.weblogic@epml07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr. Tomasz, Mr. Park, list,

First patch in the following set belongs to s5p-media, rest to exynos-drm.
Please review the media patch so that It can be merged for mainline.

regards,
Rahul Sharma

On Thu, Oct 4, 2012 at 9:12 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Tomasz Stanislawski <t.stanislaws@samsung.com>
>
> This patch extends s5p-hdmi platform data by a GPIO identifier for
> Hot-Plug-Detection pin.
>
> Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/media/s5p_hdmi.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/include/media/s5p_hdmi.h b/include/media/s5p_hdmi.h
> index 361a751..181642b 100644
> --- a/include/media/s5p_hdmi.h
> +++ b/include/media/s5p_hdmi.h
> @@ -20,6 +20,7 @@ struct i2c_board_info;
>   * @hdmiphy_info: template for HDMIPHY I2C device
>   * @mhl_bus: controller id for MHL control bus
>   * @mhl_info: template for MHL I2C device
> + * @hpd_gpio: GPIO for Hot-Plug-Detect pin
>   *
>   * NULL pointer for *_info fields indicates that
>   * the corresponding chip is not present
> @@ -29,6 +30,7 @@ struct s5p_hdmi_platform_data {
>         struct i2c_board_info *hdmiphy_info;
>         int mhl_bus;
>         struct i2c_board_info *mhl_info;
> +       int hpd_gpio;
>  };
>
>  #endif /* S5P_HDMI_H */
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

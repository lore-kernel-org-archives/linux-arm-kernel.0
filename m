From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 24 Feb 2014 21:38:38 +0200
Subject: [PATCH v5 04/10] V4L: Add driver for s5k6a3 image sensor
In-Reply-To: <1393263322-28215-5-git-send-email-s.nawrocki@samsung.com>
References: <1393263322-28215-1-git-send-email-s.nawrocki@samsung.com>
 <1393263322-28215-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140224193838.GL4869@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Mon, Feb 24, 2014 at 06:35:16PM +0100, Sylwester Nawrocki wrote:
> This patch adds subdev driver for Samsung S5K6A3 raw image sensor.
> As it is intended at the moment to be used only with the Exynos
> FIMC-IS (camera ISP) subsystem it is pretty minimal subdev driver.
> It doesn't do any I2C communication since the sensor is controlled
> by the ISP and its own firmware.
> This driver, if needed, can be updated in future into a regular
> subdev driver where the main CPU communicates with the sensor
> directly.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

[...]

> +static int s5k6a3_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> +{
> +	struct v4l2_mbus_framefmt *format = v4l2_subdev_get_try_format(fh, 0);
> +
> +	*format		= s5k6a3_formats[0];
> +	format->width	= S5K6A3_DEFAULT_WIDTH;
> +	format->height	= S5K6A3_DEFAULT_HEIGHT;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_subdev_internal_ops s5k6a3_sd_internal_ops = {
> +	.open = s5k6a3_open,
> +};

Where is this used?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

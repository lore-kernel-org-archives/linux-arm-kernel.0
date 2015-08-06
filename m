From: joe@perches.com (Joe Perches)
Date: Thu, 06 Aug 2015 08:05:36 -0700
Subject: [RFC PATCH 1/8] drm: exynos/dp: fix code style
In-Reply-To: <1438869866-23028-1-git-send-email-ykk@rock-chips.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
 <1438869866-23028-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438873536.2679.61.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-08-06 at 09:04 -0500, Yakir Yang wrote:
> make checkpatch.pl script happy

That should not be the primary reason to submit a patch.

Making it easier for human code reader to understand
what the code does should be though.

> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
[]
> @@ -123,10 +123,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>  		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
>  
>  		/* Read EDID data */
> -		retval = exynos_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
> -						EDID_HEADER_PATTERN,
> -						EDID_BLOCK_LENGTH,
> -						&edid[EDID_HEADER_PATTERN]);
> +		retval =
> +		exynos_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
> +					      EDID_HEADER_PATTERN,
> +					      EDID_BLOCK_LENGTH,
> +					      &edid[EDID_HEADER_PATTERN]);

This is a relatively uncommon style.

Because the code uses relatively long variable and
function names as well as longish macro #defines,
prefer to ignore the 80 column limit.

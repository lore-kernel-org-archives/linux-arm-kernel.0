From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 18 Jul 2014 00:42:23 +0200
Subject: [PATCH v3] ARM: dts: Add cros_ec to exynos5420-peach-pit and
 exynos5800-peach-pi
In-Reply-To: <1403627332-4688-1-git-send-email-dianders@chromium.org>
References: <1403627332-4688-1-git-send-email-dianders@chromium.org>
Message-ID: <53C8514F.4040606@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 06/24/2014 06:28 PM, Doug Anderson wrote:
> This adds cros_ec to exynos5420-peach-pit and exynos5800-peach-pi,
> including:
> * The keyboard
> * The i2c tunnel
> * The tps65090 under the i2c tunnel
> * The battery under the i2c tunnel
> 
> To add extra motivation, it should be noted that tps65090 is one of
> the things needed to get display-related FETs turned on for pit and
> pi.
> 
> Note that this relies on a few outstanding changes:
> * Needs (spi: s3c64xx: fix broken "cs_gpios" usage in the driver) and
>   (spi: s3c64xx: for DT platofrms always get the chipselect info from
>   DT node) to work properly and match the documented bindings.  See
>   <https://patchwork.kernel.org/patch/4346701/> and
>   <https://patchwork.kernel.org/patch/4346711/>
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Tushar Behera <tushar.b@samsung.com>
> 

Mark Brown as already applied the SPI DT binding fix from Naveen [0] which was
the dependency for this patch and he said that will try to send the whole series
to Torvalds before the 3.16-rc cycle ends.

So I think that it's safe now if you want to pick this patch.

Thanks a lot!

Best regards,
Javier

[0]:
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?h=for-next&id=306972cedfdedc662dd8e32a6397d0e29f2ac90e

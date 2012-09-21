From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 23:14:02 -0600
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <1348226536-22899-3-git-send-email-l.krishna@samsung.com>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
 <1348226536-22899-3-git-send-email-l.krishna@samsung.com>
Message-ID: <505BF79A.8060802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2012 05:22 AM, Leela Krishna Amudala wrote:
> This patch adds device tree based discovery support for exynos DRM-FIMD
> driver which includes driver modification to handle platform data in
> both the cases with DT and non-DT, Also adds the documentation for bindings.

> diff --git a/Documentation/devicetree/bindings/drm/exynos/fimd.txt b/Documentation/devicetree/bindings/drm/exynos/fimd.txt
...
> + - samsung,fimd-display: This property should specify the phandle of the
> +   display device node which holds the video interface timing with the
> +   below mentioned properties.
> +
> +   - lcd-htiming: Specifies the horizontal timing for the overlay. The
> +     horizontal timing includes four parameters in the following order.
> +
> +     - horizontal back porch (in number of lcd clocks)
> +     - horizontal front porch (in number of lcd clocks)
> +     - hsync pulse width (in number of lcd clocks)
> +     - Display panels X resolution.
> +
> +   - lcd-vtiming: Specifies the vertical timing for the overlay. The
> +     vertical timing includes four parameters in the following order.
> +
> +     - vertical back porch (in number of lcd lines)
> +     - vertical front porch (in number of lcd lines)
> +     - vsync pulse width (in number of lcd clocks)
> +     - Display panels Y resolution.

Should this not use the new videomode timings that are under discussion at:

http://lists.freedesktop.org/archives/dri-devel/2012-July/024875.html

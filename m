From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 10:06:04 -0500
Subject: [PATCH 4/5] drm/vc4: Add DPI driver
In-Reply-To: <1458865431-30048-5-git-send-email-eric@anholt.net>
References: <1458865431-30048-1-git-send-email-eric@anholt.net>
 <1458865431-30048-5-git-send-email-eric@anholt.net>
Message-ID: <20160325150604.GA7620@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:23:50PM -0700, Eric Anholt wrote:
> The DPI interface involves taking a ton of our GPIOs to be used as
> outputs, and routing display signals over them in parallel.
> 
> v2: Use display_info.bus_formats[] to replace our custom DT
>     properties.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/display/brcm,bcm-vc4.txt   |  36 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/vc4/Kconfig                        |   1 +
>  drivers/gpu/drm/vc4/Makefile                       |   1 +
>  drivers/gpu/drm/vc4/vc4_debugfs.c                  |   1 +
>  drivers/gpu/drm/vc4/vc4_dpi.c                      | 520 +++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.c                      |   1 +
>  drivers/gpu/drm/vc4/vc4_drv.h                      |   5 +
>  7 files changed, 565 insertions(+)
>  create mode 100644 drivers/gpu/drm/vc4/vc4_dpi.c

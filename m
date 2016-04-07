From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Apr 2016 12:57:40 -0500
Subject: [PATCH v3 4/9] drm/fsl-dcu: add extra clock for pixel clock
In-Reply-To: <1459834121-25997-5-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
 <1459834121-25997-5-git-send-email-stefan@agner.ch>
Message-ID: <20160407175740.GJ32257@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:28:36PM -0700, Stefan Agner wrote:
> The Vybrid DCU variant has two independent clock inputs, one
> for the registers (IPG bus clock) and one for the pixel clock.
> Support this distinction in the DCU DRM driver while staying
> backward compatible for old device trees.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/display/fsl,dcu.txt | 11 +++++++----

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c            |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c             | 16 +++++++++++++++-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h             |  1 +
>  4 files changed, 24 insertions(+), 6 deletions(-)

From: Rob Herring <robh@kernel.org>
To: Meng Yi <meng.yi@nxp.com>
Cc: stefan at agner.ch, mark.rutland at arm.com, daniel at ffwll.ch,
	ville.syrjala at linux.intel.com, dri-devel at lists.freedesktop.org,
	devicetree at vger.kernel.org
Subject: Re: [PATCH v5] drm/fsl-dcu: Implement gamma_lut atomic crtc
 properties
Message-ID: <20161008222405.GA9413@rob-hp-laptop>
References: <1475051069-24452-1-git-send-email-meng.yi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475051069-24452-1-git-send-email-meng.yi@nxp.com>
Date: Sat, 8 Oct 2016 17:26:22 -0500
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 04:24:29PM +0800, Meng Yi wrote:
> Gamma correction is optional and can be used to adjust the color
> output values to match the gamut of a particular TFT LCD panel
> 
> Split the DCU regs into "regs", "palette", "gamma" and "cursor".
> Create a second regmap for gamma memory space using little endian.
> The registers after the first address space are not accessed yet,
> hence new device trees would even work with old kernels. Just new
> kernel need the new format so we can access the separate gamma
> reg space.
> 
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Meng Yi <meng.yi@nxp.com>
> ---
> Changes since V1:
> -created a second regmap for gamma
> -updated the DCU DT binding
> -removed Kconfig for gamma and enable gamma when valid data filled.
> -extended and simplified comment lines.
> ---
>  .../devicetree/bindings/display/fsl,dcu.txt        | 12 +++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         | 33 ++++++++++++++++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          | 35 +++++++++++++++++++++-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          |  7 +++++
>  4 files changed, 85 insertions(+), 2 deletions(-)

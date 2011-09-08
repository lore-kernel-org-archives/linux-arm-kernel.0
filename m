From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 11:09:11 -0700
Subject: [RFC PATCH 05/10] documentation/dt: Add mpu, dsp and iva bindings
In-Reply-To: <1314191356-10963-6-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-6-git-send-email-b-cousson@ti.com>
Message-ID: <20110908180910.GE2967@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:09:11PM +0200, Benoit Cousson wrote:
> Add documentation for the OMAP4 processors bindings.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++++++++
>  Documentation/devicetree/bindings/arm/omap/iva.txt |   18 ++++++++++
>  Documentation/devicetree/bindings/arm/omap/mpu.txt |   35 ++++++++++++++++++++
>  3 files changed, 67 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/dsp.txt b/Documentation/devicetree/bindings/arm/omap/dsp.txt
> new file mode 100644
> index 0000000..8fcd82c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/dsp.txt
> @@ -0,0 +1,14 @@
> +* TI - DSP (Digital Signal Processor)
> +
> +TI DSP included in OMAP SoC
> +
> +Required properties:
> +- compatible : Should be "ti,c64" for OMAP3 & 4
> +- hwmods: "dsp"
> +
> +Examples:
> +
> +dsp {
> +    compatible = "ti,omap4-c64", "ti,c64";
> +    hwmods = "dsp";
> +};
> diff --git a/Documentation/devicetree/bindings/arm/omap/iva.txt b/Documentation/devicetree/bindings/arm/omap/iva.txt
> new file mode 100644
> index 0000000..f428e88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/iva.txt
> @@ -0,0 +1,18 @@
> +* TI - IVA (Imaging and Video Accelerator) subsystem
> +
> +The IVA contain various audio, video or imaging HW accelerator
> +depending of the version.
> +
> +Required properties:
> +- compatible : Should be:
> +  - "ti,ivahd", "ti,iva" for OMAP4
> +  - "ti,iva2", "ti,iva" for OMAP3
> +  - "ti,iva1", "ti,iva" for OMAP2

Again, be specific to the instantiation and encode the omap version
into the compatible value.  Use the form "ti,omap4-*", etc.

g.

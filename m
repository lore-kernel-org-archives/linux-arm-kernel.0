From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jun 2013 11:06:47 +0100
Subject: [PATCH v4 3/3] Documentation: Add documentation for APM X-Gene
 clock binding
In-Reply-To: <1372113263-18082-4-git-send-email-lho@apm.com>
References: <1372113263-18082-1-git-send-email-lho@apm.com>
 <1372113263-18082-2-git-send-email-lho@apm.com>
 <1372113263-18082-3-git-send-email-lho@apm.com>
 <1372113263-18082-4-git-send-email-lho@apm.com>
Message-ID: <20130626100647.GB10833@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd recommend on your next posting that you Cc devicetree-discuss
(devicetree-discuss at lists.ozlabs.org), as bindings should go there for
review.

On Mon, Jun 24, 2013 at 11:34:23PM +0100, Loc Ho wrote:
> Documentation: Add documentation for APM X-Gene clock binding with PLL and
> device clocks.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  Documentation/devicetree/bindings/clock/xgene.txt |  109 +++++++++++++++++++++
>  1 files changed, 109 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/xgene.txt b/Documentation/devicetree/bindings/clock/xgene.txt
> new file mode 100644
> index 0000000..cda90f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xgene.txt
> @@ -0,0 +1,109 @@
> +Device Tree Clock bindings for APM X-Gene
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of the following:
> +	"apm,xgene-socpll-clock" - for a X-Gene SoC PLL clock
> +	"apm,xgene-pcppll-clock" - for a X-Gene PCP PLL clock
> +	"apm,xgene-device-clock" - for a X-Gene device clock
> +
> +Required properties for SoC or PCP PLL clocks:
> +- reg : shall be the physical PLL register address for the pll clock.
> +- clocks : shall be the input parent clock phandle for the clock. This should
> +	be the reference clock.
> +- #clock-cells : shall be set to 1.
> +- clock-output-names : shall be the name of the PLL referenced by derive
> +  clock.
> +Optional properties for PLL clocks:
> +- clock-names : shall be the name of the PLL. If missing, use the device name.
> +
> +Required properties for device clocks:
> +- reg : shall be the physical CSR reset address base and/or physical CSR 
> +        divider address base if one existed.
> +- reg-names : shall be string describing the reg resource. Supported
> +              register names are "csr-reg" and "div-reg" which default
> +              to "csr-reg" if not specified.

This is somewhat difficult to read. How about:

- reg : shall be a list of address and length pairs describing the CSR
	reset and/or the divider. Either may be omitted, but at least
	one must be present.
- reg-names : shall be a string list describing the reg resource. This
              may include "csr-reg" and/or "div-reg". If this property
	      is not present, the reg property is assumed to describe
	      only "csr-reg".

Otherwise, the binding looks good to me.

Thanks,
Mark.

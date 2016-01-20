From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jan 2016 10:46:36 -0600
Subject: [PATCH v2 1/3] Documentation: Update the APM X-Gene SoC EDAC DTS
 binding for missing RB
In-Reply-To: <1453250812-15097-2-git-send-email-lho@apm.com>
References: <1453250812-15097-1-git-send-email-lho@apm.com>
 <1453250812-15097-2-git-send-email-lho@apm.com>
Message-ID: <20160120164636.GA25195@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 05:46:50PM -0700, Loc Ho wrote:
> This patch updates the APM X-Gene SoC EDAC documentation binding to
> reference the missing register bus for the the SoC EDAC.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> index 78e2a31..17b29af 100644
> --- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> @@ -20,6 +20,12 @@ Required properties:
>  - interrupts            : Interrupt-specifier for MCU, PMD, L3, or SoC error
>  			  IRQ(s).
>  
> +Optional property:
> +- regmap-rb		: Regmap of the register bus resource. This properity

s/properity/property/

> +			  is optional only for compatibility. If the RB
> +			  erorr conditions are not cleared, it will
> +			  continuously generates interrupt.

s/generates/generate/

Given this is pretty much required. I think I would move this back to 
required in the documentation, but keep the driver to allow it to be 
missing.

Rob

From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 19:22:49 -0600
Subject: [PATCH v5 6/8] Documentation: bindings: add compatible specific
 to legacy SCPI protocol
In-Reply-To: <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161110012249.ed56ik6kdffoikym@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 10:52:09PM -0600, Sudeep Holla wrote:
> This patch adds specific compatible to support legacy SCPI protocol.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index d1882c4540d0..ebd03fc93135 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -7,7 +7,9 @@ by Linux to initiate various system control and power operations.
>  
>  Required properties:
>  
> -- compatible : should be "arm,scpi"
> +- compatible : should be
> +	* "arm,scpi" : For implementations complying to SCPI v1.0 or above
> +	* "arm,legacy-scpi" : For implementations complying pre SCPI v1.0

I'd prefer that we explicitly enumerate the old versions. Are there 
many?

Rob

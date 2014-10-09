From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Oct 2014 15:57:18 +0100
Subject: [PATCH v3 6/7] dt-bindings: add irq domain parent binding
In-Reply-To: <1412864980-20273-7-git-send-email-yingjoe.chen@mediatek.com>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-7-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20141009145718.GB18384@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 03:29:39PM +0100, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> Add "arm,irq-domain-hierarchy" optional property.
> 
> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index c7d2fa1..f0bb759 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -68,6 +68,8 @@ Example:
>  		      <0xfff10100 0x100>;
>  	};
>  
> +- arm,irq-domain-hierarchy : When this property exists, gic will be used as
> +  parent for hierarchy irq domain.

IRQ domains are a Linux internal detail, and their description doesn't
belong in the DT. So this property does not look like it should be
described in the DT.

I don't see a description of any relationship between devices here, so
it's not clear to me what this property is intended to imply.

Why do you think you need this?

Thanks,
Mark.

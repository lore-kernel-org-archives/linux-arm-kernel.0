From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 May 2014 11:24:39 +0100
Subject: [PATCH 2/2] documentation/devicetree: Update GIC compat strings
In-Reply-To: <1400664501-4208-3-git-send-email-Nikolay.Borisov@arm.com>
References: <1400664501-4208-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400664501-4208-3-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140521102439.GE17827@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding devicetree at vger.kernel.org]

On Wed, May 21, 2014 at 10:28:21AM +0100, Nikolay Borisov wrote:
> Document the addition of 2 new, implementation-agnostic compatible
> strings. This allows for more flexibility such that new implementation 
> can either state whether they are an extension of an existing implementation,
> a brand new implementation or just that they conform to a standard revision
> of the GIC spec.

>From my POV it makes sense to have these to make it possible to write
DTs with new GIC variants which are implementations of the standard
rather than extensions of existing implementations.

However, DTs using these should also state exactly what variant they
are, and those strings should be documented (even if not supported
directly by the driver). It would be nice to have that mentioned in the
commit message.

Otherwise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Cheers,
Mark.

> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08..223b4cc 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -12,6 +12,8 @@ Main node required properties:
>  
>  - compatible : should be one of:
>  	"arm,gic-400"
> +	"arm,gic-v1"
> +	"arm,gic-v2"
>  	"arm,cortex-a15-gic"
>  	"arm,cortex-a9-gic"
>  	"arm,cortex-a7-gic"
> -- 
> 1.8.1.5
> 

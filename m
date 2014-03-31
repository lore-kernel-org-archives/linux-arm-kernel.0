From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 31 Mar 2014 10:30:47 +0100
Subject: [PATCH] ARM: topology: Make it clear that all CPUs need to be
 described
In-Reply-To: <1396016467-23257-1-git-send-email-broonie@kernel.org>
References: <1396016467-23257-1-git-send-email-broonie@kernel.org>
Message-ID: <20140331093046.GA2245@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 02:21:07PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The ARMv8 code will reject topologies that omit some CPUs (and it's not
> clear that it's ever sensible to do so). Update the binding document to
> make this clear.
> 
> Since we're reformatting the text also fix incorrect grammar in the
> final "Any other configuration..." section by removing "consider".

I think the commit log should be reworded, we update the bindings
because they are incomplete, not because ARMv8 code decided to reject
topologies that omit CPUs.

Patch is ok with me, thanks:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/topology.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> index 4aa20e7..1061faf 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/arm/topology.txt
> @@ -75,9 +75,10 @@ The cpu-map node can only contain three types of child nodes:
>  
>  whose bindings are described in paragraph 3.
>  
> -The nodes describing the CPU topology (cluster/core/thread) can only be
> -defined within the cpu-map node.
> -Any other configuration is consider invalid and therefore must be ignored.
> +The nodes describing the CPU topology (cluster/core/thread) can only
> +be defined within the cpu-map node and every core/thread in the system
> +must be defined within the topology.  Any other configuration is
> +invalid and therefore must be ignored.
>  
>  ===========================================
>  2.1 - cpu-map child nodes naming convention
> -- 
> 1.9.1
> 
> 

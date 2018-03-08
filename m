From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 20:38:29 -0600
Subject: [PATCH v3] dmaengine: mv_xor_v2: Fix clock resource by adding a
 register clock
In-Reply-To: <20180307154010.10430-1-gregory.clement@bootlin.com>
References: <20180307154010.10430-1-gregory.clement@bootlin.com>
Message-ID: <20180308023829.zullrqsara6epirv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 04:40:10PM +0100, Gregory CLEMENT wrote:
> On the CP110 components which are present on the Armada 7K/8K SoC we need
> to explicitly enable the clock for the registers. However it is not
> needed for the AP8xx component, that's why this clock is optional.
> 
> With this patch both clock have now a name, but in order to be backward
> compatible, the name of the first clock is not used. It allows to still
> use this clock with a device tree using the old binding.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
> Changelog:
> 
> v1 -> v2
> 
>  - Fix typos in the commit log
>  - Add more explanation in te commit log
>  - Only skip the reg clock usage if the clock is not presetn in the
>    device tree (-ENOENT)
>  - Add dt list in CC
> 
> v2 -> v3
> 
>  - Fix the ENOENT test
> 
>  .../devicetree/bindings/dma/mv-xor-v2.txt          |  6 +++++-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/dma/mv_xor_v2.c                            | 25 +++++++++++++++++-----
>  2 files changed, 25 insertions(+), 6 deletions(-)

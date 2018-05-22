From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 22 May 2018 16:15:05 +0100
Subject: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
In-Reply-To: <20180508114403.14499-2-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-2-mperttunen@nvidia.com>
Message-ID: <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/05/18 12:43, Mikko Perttunen wrote:
> Non-doorbell interrupts are routed through "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings.

Reading the Tegra documentation, although the doorbells have dedicated 
interrupts, it appears that the doorbell interrupts can also be routed 
via these shared interrupts.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> index b99d25fc2f26..9edcdf82d719 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> @@ -21,6 +21,8 @@ Required properties:
>       Contains a list of names for the interrupts described by the interrupt
>       property. May contain the following entries, in any order:
>       - "doorbell"
> +    - "sharedN", where 'N' is a number from zero up to the number of
> +      external interrupts supported by the HSP instance minus one.
>       Users of this binding MUST look up entries in the interrupt property
>       by name, using this interrupt-names property to do so.
>   - interrupts

How is the mapping of shared-mailboxes interrupts to the actual 
'sharedN' interrupt managed?

Cheers
Jon

-- 
nvpublic

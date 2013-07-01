From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Jul 2013 17:07:46 -0600
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,
 memory-clients"
In-Reply-To: <20130626101816.GE27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
 <20130626101816.GE27083@manwe>
Message-ID: <51D20BC2.4090302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2013 04:18 AM, Thierry Reding wrote:
> On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote: 
> [...]
>> diff --git
>> a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
>
>> 
[...]
>> @@ -23,3 +24,13 @@ Example: nvidia,swgroups = <0x00000000
>> 0x000779ff>; nvidia,ahb = <&ahb>; }; + +	host1x { +		compatible =
>> "nvidia,tegra30-host1x", "simple-bus"; +		nvidia,memory-clients =
>> <SWGID_HC>;
> 
> And this could use the SWGID(HC) to match up with how GPIOs are 
> referenced in the DTS files.

I only made TEGRA_GPIO(bank, id) a macro because there was a regular
bank/id structure to the GPIO numbering. I haven't read these patches
yet, but I assume SWGIDs are just a flat numbering space with
arbitrarily assigned number in HW, so there's no much point saying
SWGID(X) rather than SWGID_X.

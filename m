From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 10:51:42 -0600
Subject: [PATCHv3 3/4] iommu/tegra: smmu: Refrain from accessing to AHB
In-Reply-To: <20120504.093358.2098007825524274078.hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com><1336061147-10245-3-git-send-email-hdoyu@nvidia.com><4FA2C4E9.2080509@wwwdotorg.org>
 <20120504.093358.2098007825524274078.hdoyu@nvidia.com>
Message-ID: <4FA4091E.60508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 12:33 AM, Hiroshi Doyu wrote:
> Stephen Warren wrote at Thu, 3 May 2012 19:48:25 +0200:
>> On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
>>> Use "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
>>> ready, instead of directly aceessing AHB registers.
...
>>> @@ -911,14 +899,16 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>>
>>> +	smmu->ahb = of_parse_phandle(pdev->dev.of_node, "ahb", 0);
>>
>> Hmm, "ahb" should probably be "nvidia,ahb".
> 
> Does this mean the following in dts?
> 
> 	ahb: ahb at 6000c004 {
> 		compatible = "nvidia,tegra30-ahb";
> 		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
> 	};
> 
> 	smmu: smmu at 7000f000 {
> 		nvidia,ahb = &ahb;
> 	};      ^^^^^^^^^^
> 

Yes.

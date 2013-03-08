From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 11:41:23 -0700
Subject: [PATCH 1/5] ARM: DT: tegra114: add APB DMA controller DT entry
In-Reply-To: <513A2888.5020402@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-2-git-send-email-ldewangan@nvidia.com>
 <513A250C.1000202@wwwdotorg.org> <513A2888.5020402@nvidia.com>
Message-ID: <513A30D3.4020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 11:06 AM, Laxman Dewangan wrote:
> On Friday 08 March 2013 11:21 PM, Stephen Warren wrote:
>> On 03/08/2013 06:52 AM, Laxman Dewangan wrote:
>>> NVIDIA's Tegra114 has 32 channels APB DMA controller. Add DT entry for
>>> APB DMA controllers and make it compatible with
>>> "nvidia,tegra114-apbdma".
>>> diff --git a/arch/arm/boot/dts/tegra114.dtsi
>>> b/arch/arm/boot/dts/tegra114.dtsi
>>> +    apbdma: dma {
>>> +        compatible = "nvidia,tegra114-apbdma";
>> So I know that the Tegra114 HW has a new channel-pause feature, which
>> the driver /can/ use. However, if the driver didn't know about that
>> feature, and continued to use the global-pause feature, would it still
>> work fine?
>>
>> In other words, is the Tegra114 HW 100% backwards-compatible with the
>> Tegra30 HW, it's just that there are new features that SW could
>> optionally use?
>>
>> If that is true, then we should also include "nvidia,tegra30-apbdma" in
>> the compatible value.
> 
> Tegra114 HW is not compatible with the tegra30 as with global pause, it
> is not able to write into the dma register in T114. On t114, the dma
> register is clock gated with global enable/disable.

Interesting. In that case, the compatible value above is entirely
correct. Thanks for the explanation. It might be worth mentioning this
in the commit description.

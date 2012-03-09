From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Mar 2012 09:47:11 -0700
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120309063115.GA25208@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120309063115.GA25208@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F5A340F.6080303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 11:31 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> This commit adds support for instantiating the Tegra PCIe controller
>>> from a device tree.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>>> diff --git a/Documentation/devicetree/bindings/pci/tegra-pcie.txt b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
>>
>>> +NVIDIA Tegra PCIe controller
>>> +
>>> +Required properties:
>>> +- compatible: "nvidia,tegra20-pcie"
>>> +- reg: physical base address and length of the controller's registers
>>> +- interrupts: the interrupt outputs of the controller
>>> +
>>> +Optional properties:
>>> +- pex-clk-supply: supply voltage for internal reference clock
>>> +- vdd-supply: power supply for controller (1.05V)
>>
>> Mark, Liam,
>>
>> Should those *-supply properties really be optional? I got the
>> impression talking to Mark in a different thread that all regulators
>> should exist, although their implementation may be via a fixed
>> regulator, with no GPIO, as determined by the board design.
> 
> If I read the TrimSlice code correctly, there is no regulator setup required
> to make PCIe work there presumably because they hardwire the proper voltages.

Yes. I believe that's exactly what the fixed regulator is for.

> On the other hand, maybe a better solution in this case would be to use the
> dummy regulator in those cases.

Mark indicated dummy regulators weren't the preferred mechanism:

http://lkml.org/lkml/2012/2/25/30

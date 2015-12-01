From: rjui@broadcom.com (Ray Jui)
Date: Tue, 1 Dec 2015 15:16:54 -0800
Subject: [PATCH] Enable PCIe PHY support in Cygnus
In-Reply-To: <565E2969.7000500@gmail.com>
References: <1447870619-2828-1-git-send-email-rjui@broadcom.com>
 <5654FCF5.40406@gmail.com> <565E2969.7000500@gmail.com>
Message-ID: <565E2A66.7050306@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/1/2015 3:12 PM, Florian Fainelli wrote:
> On 24/11/15 16:12, Florian Fainelli wrote:
>> On 18/11/15 10:16, Ray Jui wrote:
>>> This patch enales PCIe PHY in device tree for Broadcom Cygnus based platforms
>>>
>>> This patch is developed based on v4.4-rc1 and available here:
>>> https://github.com/Broadcom/cygnus-linux/tree/cygnus-pcie-phy-dt-v1
>>>
>>> Ray Jui (1):
>>>    ARM: dts: enable PCIe PHY support for Cygnus
>>
>> Applied to devicetree/next with Scott's Acked-by, thanks!
>
> This caused the DTC compiler to warn:
>
> Warning (reg_format): "reg" property in /axi/phy at 0301d0a0/phy at 0 has
> invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /axi/phy at 0301d0a0/phy at 1 has
> invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells
> value for /axi/phy at 0301d0a0/phy at 0
> Warning (avoid_default_addr_size): Relying on default #size-cells value
> for /axi/phy at 0301d0a0/phy at 0
> Warning (avoid_default_addr_size): Relying on default #address-cells
> value for /axi/phy at 0301d0a0/phy at 1
> Warning (avoid_default_addr_size): Relying on default #size-cells value
> for /axi/phy at 0301d0a0/phy at 1
>    CC      drivers/base/power/runtime.o
>    DTC     arch/arm/boot/dts/bcm911360k.dtb
>    CC      lib/bitmap.o
>
> I added an #address-cells = <0> and #size-cells = <1> to fix this, since
> your reg property is a single digit.
>

Sorry I missed that. Both are required properties.

Thanks!

Ray

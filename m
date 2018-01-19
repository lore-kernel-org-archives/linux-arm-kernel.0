From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Fri, 19 Jan 2018 12:55:58 +0800
Subject: [PATCH v4 07/13] ARM: dts: rockchip: add clocks in vop iommu nodes
In-Reply-To: <CAAFQd5ACbV6Q2Jwze=hoG=13jSJKkYyDDs2HzvvdSK-RGK+w2g@mail.gmail.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-8-jeffy.chen@rock-chips.com>
 <CAAFQd5ACbV6Q2Jwze=hoG=13jSJKkYyDDs2HzvvdSK-RGK+w2g@mail.gmail.com>
Message-ID: <5A617A5E.6070606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Thanks for your reply.

On 01/19/2018 11:23 AM, Tomasz Figa wrote:
> On Thu, Jan 18, 2018 at 8:52 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Add clocks in vop iommu nodes, since we are going to control clocks in
>> rockchip iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   arch/arm/boot/dts/rk3036.dtsi | 2 ++
>>   arch/arm/boot/dts/rk3288.dtsi | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
>> index 3b704cfed69a..95b0ebc7a40f 100644
>> --- a/arch/arm/boot/dts/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rk3036.dtsi
>> @@ -197,6 +197,8 @@
>>                  reg = <0x10118300 0x100>;
>>                  interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>>                  interrupt-names = "vop_mmu";
>> +               clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru HCLK_LCDC>;
>> +               clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
>
> We should remove clock-names from IOMMU nodes. The Rockchip IOMMU
> bindings don't define clock names and only the clocks property should
> be given.
>
hmmm, i'm trying to switch to clk_bulk APIs, the get and put are name 
based. or maybe i can use clk_get/put along with other clk_bulk APIs
> Not even saying that the names currently listed are not good examples,
> they name SoC clock controller output, rather than device inputs.
>
> Best regards,
> Tomasz
>
>
>

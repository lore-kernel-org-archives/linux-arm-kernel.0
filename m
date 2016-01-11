From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 11 Jan 2016 11:48:15 +0800
Subject: [RFC PATCH v2 4/4] dt-bindings: add document for rk3229-hdmi
In-Reply-To: <20160111020618.GA20680@rob-hp-laptop>
References: <1452156811-18150-1-git-send-email-ykk@rock-chips.com>
 <1452157511-18891-1-git-send-email-ykk@rock-chips.com>
 <20160111020618.GA20680@rob-hp-laptop>
Message-ID: <569325FF.10902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/11/2016 10:06 AM, Rob Herring wrote:
> On Thu, Jan 07, 2016 at 05:05:11PM +0800, Yakir Yang wrote:
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v2: None
>>
>>   .../devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt         | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
>> index 668091f..1cdc627 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
>> +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
>> @@ -2,7 +2,7 @@ Rockchip specific extensions to the Synopsys Designware HDMI
>>   ================================
>>   
>>   Required properties:
>> -- compatible: "rockchip,rk3288-dw-hdmi";
>> +- compatible: "rockchip,rk3288-dw-hdmi", "rockchip,rk3229-dw-hdmi";
>>   - reg: Physical base address and length of the controller's registers.
>>   - clocks: phandle to hdmi iahb and isfr clocks.
>>   - clock-names: should be "iahb" "isfr"
>> @@ -15,8 +15,10 @@ Required properties:
>>     rk3288 platform
>>   
>>   Optional properties
>> +- reg: Physical base address and length of the external HDMI PHY's registers.
> This is already required...
>

The original reg only include the DW HDMI controller registers:
         reg = <0x200a0000 0x20000>;

But for now, I need to pass the external HDMI PHY registers:
         reg = <0x200a0000 0x20000>, <0x12030000 0x10000>;

>>   - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
>>   - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
>> +		       phandle to the external HDMI PHY clock, name should be "extphy"
> Does this change apply to rk3288 or just rk3229? If the latter, you
> should make that clear. The driver needs to allow for old dtb's that
> only have 1 clock.

It's the latter one, driver have allowed that by judging the device type,
but I should make the document more clear.

> Based on Philipp's feedback, you also need to add a phys property.

Yes, I'm preparing the new patches that create a new separate phy
driver for external HDMI phy, there would be much difference from
this version.

Thanks for your respond,
- Yakir

>
> Rob
>
>
>

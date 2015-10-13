From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 13 Oct 2015 09:21:41 +0800
Subject: [PATCH v6 11/17] Documentation: phy: add document for rockchip
 dp phy
In-Reply-To: <561C3410.8090600@ti.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
 <1444492695-27241-1-git-send-email-ykk@rock-chips.com>
 <561C3410.8090600@ti.com>
Message-ID: <561C5CA5.1030403@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 10/13/2015 06:28 AM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Saturday 10 October 2015 09:28 PM, Yakir Yang wrote:
>> This phy driver is binded with the Rockchip DisplayPort
>> driver, here are the brief properties:
>> 	edp_phy: edp-phy at ff770274 {
>> 		compatible = "rockchip,rk3288-dp-phy";
>> 		rockchip,grf = <&grf>;
>> 		clocks = <&cru SCLK_EDP_24M>;
>> 		clock-names = "24m";
>> 		#phy-cells = <0>;
>> 	};
> The commit message can simply be "Add dt binding documentation for
> rockchip display port PHY".

Okay, thanks.

- Yakir

>
> Thanks
> Kishon
>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v6: None
>> Changes in v5:
>> - Split binding doc's from driver changes. (Rob)
>> - Update the rockchip,grf explain in document, and correct the clock required
>>    elemets in document. (Rob & Heiko)
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   .../devicetree/bindings/phy/rockchip-dp-phy.txt    | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>> new file mode 100644
>> index 0000000..505194e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>> @@ -0,0 +1,22 @@
>> +Rockchip Soc Seroes Display Port PHY
>> +------------------------------------
>> +
>> +Required properties:
>> +- compatible : should be one of the following supported values:
>> +	 - "rockchip.rk3288-dp-phy"
>> +- clocks: from common clock binding: handle to dp clock.
>> +	of memory mapped region.
>> +- clock-names: from common clock binding:
>> +	Required elements: "24m"
>> +- rockchip,grf: phandle to the syscon managing the "general register files"
>> +- #phy-cells : from the generic PHY bindings, must be 0;
>> +
>> +Example:
>> +
>> +edp_phy: edp-phy at ff770274 {
>> +	compatible = "rockchip,rk3288-dp-phy";
>> +	rockchip,grf = <&grf>;
>> +	clocks = <&cru SCLK_EDP_24M>;
>> +	clock-names = "24m";
>> +	#phy-cells = <0>;
>> +};
>>
>
>

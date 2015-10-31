From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 31 Oct 2015 11:13:48 +0800
Subject: [PATCH v8 11/17] dt-bindings: add document for rockchip dp phy
In-Reply-To: <CAL_JsqL=pL8SXLEzhbJHS_djFSh+Ctky0igzagZ6E0M9Q_TFuA@mail.gmail.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446021068-11655-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqL=pL8SXLEzhbJHS_djFSh+Ctky0igzagZ6E0M9Q_TFuA@mail.gmail.com>
Message-ID: <563431EC.9050701@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/31/2015 12:42 AM, Rob Herring wrote:
> On Wed, Oct 28, 2015 at 3:31 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>> Add dt binding documentation for rockchip display port PHY.
>>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,

- Yakir

>> ---
>> Changes in v8:
>> - Remove the specific address in the example node name. (Heiko)
>>
>> Changes in v7:
>> - Simplify the commit message. (Kishon)
>>
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
>> index 0000000..00902cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
>> @@ -0,0 +1,22 @@
>> +Rockchip Soc Seroes Display Port PHY
>> +------------------------------------
>> +
>> +Required properties:
>> +- compatible : should be one of the following supported values:
>> +        - "rockchip.rk3288-dp-phy"
>> +- clocks: from common clock binding: handle to dp clock.
>> +       of memory mapped region.
>> +- clock-names: from common clock binding:
>> +       Required elements: "24m"
>> +- rockchip,grf: phandle to the syscon managing the "general register files"
>> +- #phy-cells : from the generic PHY bindings, must be 0;
>> +
>> +Example:
>> +
>> +edp_phy: edp-phy {
>> +       compatible = "rockchip,rk3288-dp-phy";
>> +       rockchip,grf = <&grf>;
>> +       clocks = <&cru SCLK_EDP_24M>;
>> +       clock-names = "24m";
>> +       #phy-cells = <0>;
>> +};
>> --
>> 1.9.1
>>
>>
>
>

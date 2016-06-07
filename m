From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 7 Jun 2016 08:33:23 +0800
Subject: [v1 PATCH 1/4] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <20160606142738.GA12472@rob-hp-laptop>
References: <1464966911-18949-1-git-send-email-zyw@rock-chips.com>
 <1464966911-18949-2-git-send-email-zyw@rock-chips.com>
 <20160606142738.GA12472@rob-hp-laptop>
Message-ID: <57561653.9060404@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 06/06/2016 10:27 PM, Rob Herring wrote:
> On Fri, Jun 03, 2016 at 11:15:08PM +0800, Chris Zhong wrote:
>> This patch adds a binding that describes the Rockchip USB Type-C PHY
>> for rk3399
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>
>> ---
>>
>> Changes in v1:
>> - add extcon node description
>> - move the registers in phy driver
>> - remove the suffix of reset
>>
>>   .../devicetree/bindings/phy/phy-rockchip-typec.txt | 46 ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> new file mode 100644
>> index 0000000..964e0f7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>> @@ -0,0 +1,46 @@
>> +* ROCKCHIP type-c PHY
>> +---------------------
>> +
>> +Required properties:
>> + - compatible: should be "rockchip,rk3399-typec-phy0" or
>> +			 "rockchip,rk3399-typec-phy1"
> What's the difference between 0 and 1? If it is to handle the register
> offsets you have in the previous version and the phy blocks are
> identical, then the compatible strings should be the same.
yes, the registers are different between 0 and 1, and there is a grf 
register(0x6268) for switch the phy 0 and phy 1


>
>> + - reg : Address and length of the usb phy control register set
>> + - rockchip,grf : phandle to the syscon managing the "general
>> +   register files"
>> + - clocks : phandle + clock specifier for the phy clocks
>> + - clock-names: string, clock name, must be "tcpdcore", "tcpdphy_ref";
>> + - resets : a list of phandle + reset specifier pairs
>> + - reset-names : string reset name, must be:
>> +		 "tcphy", "tcphy_pipe", "uphy_tcphy"
>> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
>> + - extcon: extcon specifier for the Power Delivery
>
>

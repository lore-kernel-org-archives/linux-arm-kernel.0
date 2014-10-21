From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 13:46:30 +0200
Subject: [PATCH 8/9] ARM: berlin: Add phy-connection-type to BG2Q PHY
In-Reply-To: <54464401.20900@cogentembedded.com>
References: <1413881627-21639-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413881627-21639-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <54464401.20900@cogentembedded.com>
Message-ID: <54464796.90804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.10.2014 13:31, Sergei Shtylyov wrote:
> Hello.
>
> On 10/21/2014 12:53 PM, Sebastian Hesselbarth wrote:
>
>> From: Antoine T?nart <antoine.tenart@free-electrons.com>
>
>> Internal FastEthernet PHY on BG2Q is connected via MII, add a
>> corresponding phy-connection-type property.
>
>> Tested-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: netdev at vger.kernel.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>   arch/arm/boot/dts/berlin2q.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>
>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
>> b/arch/arm/boot/dts/berlin2q.dtsi
>> index 891d56b03922..6dbc520bddc1 100644
>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
>> @@ -127,6 +127,7 @@
>>               status = "disabled";
>>
>>               ethphy0: ethernet-phy at 0 {
>> +                phy-connection-type = "mii";
>
>     You're adding this prop to the PHY node? That's very weird...
> normally, it's a property of a MDIO bus node.

Sergei,

How can this be a property of the MDIO bus node? Just think of an MDIO
bus with two PHYs where one is connected via GMII and the other via
RGMII? How should this work?

But you are right that the property should not be part of the PHY node
but the controller node instead. I'll rework and send an update, thanks
for the hint.

Sebastian

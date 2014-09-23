From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 23 Sep 2014 18:40:46 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <9401592.hUYDkriFVO@wuerfel>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <4014272.rJbSfrLcuB@wuerfel> <542195B0.6080706@gmail.com>
 <9401592.hUYDkriFVO@wuerfel>
Message-ID: <5421A28E.7060600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 06:29 PM, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 17:45:52 Sebastian Hesselbarth wrote:
>> For reference, this is what we have for MVEBU SoCs with multiple ports
>> per controller:
>>
>> eth: ethernet-ctrl at 72000 {
>>          compatible = "marvell,orion-eth";
...
>>          reg = <0x72000 0x4000>;
...
>>
>>          ethernet-port at 0 {
>>                  compatible = "marvell,orion-eth-port";
...
>>                  phy-handle = <&ethphy>;
>>          };
>> };
>>
>> mdio: mdio-bus at 72004 {
>>          compatible = "marvell,orion-mdio";
...
>>          reg = <0x72004 0x84>;
..
>>          ethphy: ethernet-phy {
>>                  /* set phy address in board file */
>>          };
>> };

> But in this example, you have the same registers and the same
> clocks in two nodes, which are even used by the same device driver
> at the moment. It's not a big issue, but my feeling is that Antoine's
> approach was actually better because it more closely reflects
> the way that the hardware is built.

I was not referring to the separate mdio bus node, but putting the
ethernet-phy node as a child of ethernet-ctrl.

Anyway, I can live with the ethernet-phy being a child of the controller
node until we discover where it is hooked up.

For the internal MII PHY the controller node maybe is the only sane
place to put it in. The HEC PHY will reside within the CEC IP node but
that is compatible with Antoine's proposal.

Sebastian

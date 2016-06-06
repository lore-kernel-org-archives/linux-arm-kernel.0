From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Mon, 6 Jun 2016 20:10:54 +0200
Subject: [PATCH 3/5] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <20160606141438.GA9510@rob-hp-laptop>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
 <1464947790-22991-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160606141438.GA9510@rob-hp-laptop>
Message-ID: <5755BCAE.6060307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/06/2016 16:14, Rob Herring a ?crit :
> On Fri, Jun 03, 2016 at 11:56:28AM +0200, LABBE Corentin wrote:
>> This patch adds documentation for Device-Tree bindings for the
>> Allwinner sun8i-emac driver.
>>
>> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
>> ---
>>  .../bindings/net/allwinner,sun8i-emac.txt          | 64 ++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>> new file mode 100644
>> index 0000000..cf71a71
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>> @@ -0,0 +1,64 @@
>> +* Allwinner sun8i EMAC ethernet controller
>> +
>> +Required properties:
>> +- compatible: "allwinner,sun8i-a83t-emac", "allwinner,sun8i-h3-emac",
>> +		or "allwinner,sun50i-a64-emac"
>> +- reg: address and length of the register sets for the device.
>> +- reg-names: should be "emac" and "syscon", matching the register sets
> 
> Is syscon shared with other devices? Your example only has 1 reg 
> address.
> 

The example is bad, emac and syscon are two distinct regspaces.
I will correct the example.

>> +- interrupts: interrupt for the device
>> +- clocks: A phandle to the reference clock for this device
>> +- clock-names: should be "ahb"
>> +- resets: A phandle to the reset control for this device
>> +- reset-names: should be "ahb"
>> +- phy-mode: See ethernet.txt
>> +- phy or phy-handle: See ethernet.txt
>> +- #address-cells: shall be 1
>> +- #size-cells: shall be 0
>> +
>> +"allwinner,sun8i-h3-emac" also requires:
>> +- clocks: an extra phandle to the reference clock for the EPHY
>> +- clock-names: an extra "ephy" entry matching the clocks property
>> +- resets: an extra phandle to the reset control for the EPHY
>> +- resets-names: an extra "ephy" entry matching the resets property
>> +
>> +See ethernet.txt in the same directory for generic bindings for ethernet
>> +controllers.
>> +
>> +The device node referenced by "phy" or "phy-handle" should be a child node
>> +of this node. See phy.txt for the generic PHY bindings.
>> +
>> +Optional properties:
>> +- phy-supply: phandle to a regulator if the PHY needs one
>> +- phy-io-supply: phandle to a regulator if the PHY needs a another one for I/O.
>> +		 This is sometimes found with RGMII PHYs, which use a second
>> +		 regulator for the lower I/O voltage.
> 
> These should go in the phy's node.
> 

In fact, I forgot to remove them, since for the moment, the driver sent do not have any regulator support.

Thanks

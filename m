From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Jun 2017 14:48:31 +0100
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170606133446.GI4902@n2100.armlinux.org.uk>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606133446.GI4902@n2100.armlinux.org.uk>
Message-ID: <b3bf3f20-76c0-bb12-6b20-0a7dad222793@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/17 14:34, Russell King - ARM Linux wrote:
> On Mon, Jun 05, 2017 at 09:01:07PM +0100, Marc Zyngier wrote:
>> Enable the 1GB Ethernet interface that lives on the slave CP110,
>> with its corresponding phy (that oddly lives on the master CP110).
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> index f7bb0cc03147..1eb3cd5332c1 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> @@ -100,6 +100,12 @@
>>  	status = "okay";
>>  };
>>  
>> +&cpm_mdio {
>> +	phy0: ethernet-phy at 0 {
> 
> As the board has multiple phys, can we use a more descriptive label
> here, such as "ge_phy" (for gigabit ethernet phy) to distinugish it
> from the 10G PHYs?
> 
>> +&cps_ethernet {
>> +	status = "okay";
>> +};
>> +
>> +&cps_eth1 {
> 
> Labelling up the connector as is done elsewhere in the file would be
> nice:
> 
> 	/* CPS Lane 0 - J5 (Gigabit RJ45) */
> 
> 
>> +	status = "okay";
>> +	phy = <&phy0>;
>> +	phy-mode = "sgmii";
> 

Yup, agreed on both counts. I'll update the patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

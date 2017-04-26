From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Apr 2017 10:26:44 -0700
Subject: [PATCH v2 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <0cb00eb7-41d0-0390-4687-d966499ed9f4@gmail.com>
References: <20170425235357.7690-1-eric@anholt.net>
 <20170425235357.7690-2-eric@anholt.net>
 <0cb00eb7-41d0-0390-4687-d966499ed9f4@gmail.com>
Message-ID: <87r30fjd0r.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 04/25/2017 04:53 PM, Eric Anholt wrote:
>> Cygnus has a single AMAC controller connected to the B53 switch with 2
>> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
>> the external ethernet jacks.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> 
>> v2: Call the node "switch", just call the ports "port" (suggestions by
>>     Florian), drop max-speed on the phys (suggestion by Andrew Lunn),
>>     call the other nodes "ethernet" and "ethernet-phy" (suggestions by
>>     Sergei Shtylyov)
>> 
>>  arch/arm/boot/dts/bcm-cygnus.dtsi      | 58 ++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++++
>>  2 files changed, 66 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 009f1346b817..9fd89be0f5e0 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -142,6 +142,54 @@
>>  			interrupts = <0>;
>>  		};
>>  
>> +		mdio: mdio at 18002000 {
>> +			compatible = "brcm,iproc-mdio";
>> +			reg = <0x18002000 0x8>;
>> +			#size-cells = <1>;
>> +			#address-cells = <0>;
>
> Sorry for not noticing earlier, since you override this correctly in the
> board-level DTS file can you put a:
>
> 			status = "disabled"
>
> property in there by default?

Done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/e5d1c373/attachment-0001.sig>

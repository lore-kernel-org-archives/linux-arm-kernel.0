From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Sep 2014 16:34:02 +0200
Subject: [PATCH v5 09/10] ARM: dts: berlin: add the Ethernet node
In-Reply-To: <5425A178.4050501@cogentembedded.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411742036-23520-10-git-send-email-antoine.tenart@free-electrons.com>
 <5425A178.4050501@cogentembedded.com>
Message-ID: <54296DDA.8000400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2014 07:25 PM, Sergei Shtylyov wrote:
> On 09/26/2014 06:33 PM, Antoine Tenart wrote:
>> This patch adds the Ethernet node, enabling the network unit on Berlin
>> BG2Q SoCs.
>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/arm/boot/dts/berlin2q.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
>> b/arch/arm/boot/dts/berlin2q.dtsi
>> index 902eddb19cd8..d442b22fd1ea 100644
>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
>> @@ -114,6 +114,23 @@
>>               #interrupt-cells = <3>;
>>           };
>>
>> +        eth0: ethernet at b90000 {
>> +            compatible = "marvell,pxa168-eth";
>> +            reg = <0xb90000 0x10000>;
>> +            clocks = <&chip CLKID_GETH0>;
>> +            interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> +            /* set by bootloader */
>> +            local-mac-address = [00 00 00 00 00 00];
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            phy-handle = <&ethphy0>;
>> +            status = "disabled";
>> +
>> +            ethphy0: ethernet-phy at 0 {
>> +                reg = <0>;
>> +            };
>> +        };
>> +
>
>     Hm, is the PHY internal to the Ethernet controller?

Sergei,

at least for BG2 and BG2CD the PHY is internal to the SoC. Also,
MDIO bus is part of the ethernet IP, so placing the PHY inside
the combined Ethernet/MDIO IP node is sane.

Sebastian

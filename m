From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 25 Jun 2014 16:40:49 +0800
Subject: [PATCH 1/2] ARM: at91/dt: describe rgmii ethernet phy connected
 to sama5d3xek boards
In-Reply-To: <53AA7E01.3090800@free-electrons.com>
References: <1403649878-28242-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403649878-28242-2-git-send-email-boris.brezillon@free-electrons.com>
 <53AA735C.7050805@atmel.com> <53AA7A8C.1010304@free-electrons.com>
 <53AA7BC6.3020902@atmel.com> <53AA7E01.3090800@free-electrons.com>
Message-ID: <53AA8B11.6010907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/25/2014 03:45 PM, Boris BREZILLON wrote:
>
> On 25/06/2014 09:35, Bo Shen wrote:
>> Hi Boris,
>>
>> On 06/25/2014 03:30 PM, Boris BREZILLON wrote:
>>> Hello Bo,
>>>
>>> On 25/06/2014 08:59, Bo Shen wrote:
>>>> Hi Boris,
>>>>
>>>> On 06/25/2014 06:44 AM, Boris BREZILLON wrote:
>>>>> Add ethernet-phy node to specify phy address (on the MDIO bus) and phy
>>>>> interrupt (connected to pin PB25).
>>>>>
>>>>> Define board specific delays to apply to RGMII signals.
>>>>>
>>>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>>>>> ---
>>>>> arch/arm/boot/dts/sama5d3xcm.dtsi | 16 ++++++++++++++++
>>>>> 1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi
>>>>> b/arch/arm/boot/dts/sama5d3xcm.dtsi
>>>>> index b0b1331..2185ad8 100644
>>>>> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
>>>>> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
>>>>> @@ -34,6 +34,22 @@
>>>>>
>>>>> macb0: ethernet at f0028000 {
>>>>> phy-mode = "rgmii";
>>>>> + #address-cells = <1>;
>>>>> + #size-cells = <0>;
>>>>> +
>>>>> + ethernet-phy at 1 {
>>>>
>>>> The GMAC PHY address is 0x7 while not 0x1.
>>>
>>> Are you sure of that ? I checked sama5d3x-ek schematics.
>>
>> On sama5d3x-ek schematic, it is EMAC PHY (ksz8051RNL, it's address is
>> 0x1), while not GMAC PHY. You should check the sama5d3x-CM schematic.
>
> I checked "Figure 5-16. RONETIX GEthernet ETH0" and "Figure 5-15. EMBEST
> GEthernet ETH0" of this document "11180A?ATARM?30-Jan-13", which,
> AFAICT, are RGMII phy schematics of CPU Modules.
> I might have an old datasheet though.
> If this is the case could you point out the new one ?

After checking the schematic carefully, I found it will make the user 
confuse.

When the PHY do strap the status of configuration pins. The phy address 
pin are all pull up.

The PHYADD2(LED2) pin pull up to v3.3, the PHYADD1 (LED1) pin pull up to 
v3.3, the RX_CLK (PHADD0) pin pull up by default through sama5d3 pin.

So, they are all "1", then the PHY address is 7.

> Thanks,
>
> Boris

Best Regards,
Bo Shen

From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 7 Dec 2013 09:35:04 +0800
Subject: [PATCH 07/10] ARM: dts: sun7i: cubietruck: Enable the GMAC
In-Reply-To: <CAGVrzcb_r9_p4urz4XkE2A-G85KAHJa4PJ=Gt9a4RPYQNJ6j0g@mail.gmail.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-8-git-send-email-wens@csie.org>
 <CAGVrzcb_r9_p4urz4XkE2A-G85KAHJa4PJ=Gt9a4RPYQNJ6j0g@mail.gmail.com>
Message-ID: <CAGb2v64yFhkTXvdq=1VpemULhXew-5fvmSoTBzEb6iFDiSqy1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 7, 2013 at 5:09 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2013/12/6 Chen-Yu Tsai <wens@csie.org>:
>> The CubieTruck uses the GMAC with an RGMII phy.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> index 8a1009d..af212a2 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> @@ -33,6 +33,14 @@
>>                         pinctrl-0 = <&uart0_pins_a>;
>>                         status = "okay";
>>                 };
>> +
>> +               gmac: ethernet at 01c50000 {
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&gmac_pins_rgmii>;
>> +                       snps,phy-addr = <1>;
>
> What is this snps,phy-addr property? Why is not a standard device tree
> node for an Ethernet PHY node used?

This property is implemented by stmmac and documented in the DT
bindings. stmmac has not been updated to use Ethernet PHY nodes.

Removing this property will not affect the function of the driver.
The driver probes its MDIO bus and selects the lowest available
address if not specified.

>> +                       phy-mode = "rgmii";
>
> Especially since you use the relatively standard "phy-mode" property here?

Used as specified in stmmac DT bindings.


Wens

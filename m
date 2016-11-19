From: tomas.hlavacek@nic.cz (tomas.hlavacek at nic.cz)
Date: Sat, 19 Nov 2016 21:09:07 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161114202832.GG24546@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch>
Message-ID: <1479586147.10840.0@smtp.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe!

On Mon, Nov 14, 2016 at 9:28 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>>  +               i2c at 7 {
>>  +                       #address-cells = <1>;
>>  +                       #size-cells = <0>;
>>  +                       reg = <7>;
>>  +
>>  +                       pcawan: gpio at 71 {
>>  +                               compatible = "nxp,pca9538";
>>  +                               reg = <0x71>;
>>  +
>>  +                               pinctrl-names = "default";
>>  +                               pinctrl-0 = <&pcawan_pins>;
>>  +
>>  +                               interrupt-parent = <&gpio1>;
>>  +                               interrupts = <14 
>> IRQ_TYPE_LEVEL_LOW>;
>>  +
>>  +                               gpio-controller;
>>  +                               #gpio-cells = <2>;
>>  +
>>  +                               interrupt-controller;
>>  +                               #interrupt-cells = <2>;
>>  +                       };
>>  +               };
>> 
>>  The interrupt-controller part doesn't seem to work though, at least
>> 
>>  +               interrupt-parent = <&pcawan>;
>>  +               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
>> 
>>  in the phy node gives an error.
> 
> Interrupts don't seem to work very well with the nxp,pca9538. Which
> is probably why it is disabled by default.

I was thinking about this issue and I can remember that there was an 
earlier prototype that had a shared interrupt line from PHY (88E1514) 
and from the PCA9538. In this case we needed to specifically disable 
the interrupt of the PHY to release the interrupt line (which needed a 
hack into PHY driver code). The IRQ from PHY is connected as an 
ordinary input to PCA9538 in later board prototype. And the same holds 
for the production version.

Do you have CZ11NIC13 or older board revision?

Tomas

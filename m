From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Nov 2017 23:42:59 +0100
Subject: [PATCH] ARM: dts: Add basic devicetree for D-Link DNS-313
In-Reply-To: <20171129161038.GG24881@lunn.ch>
References: <20171129154720.16662-1-linus.walleij@linaro.org>
 <20171129161038.GG24881@lunn.ch>
Message-ID: <CACRpkdZgucPuk=W7KJON-REXuvA87ZY3DNaLrDO98ZVGD-_Rgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 5:10 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> +     mdio0: ethernet-phy {
>> +             compatible = "virtual,mdio-gpio";
>> +             /* Uses MDC and MDIO */
>> +             gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
>> +                     <&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             /* This is a Realtek RTL8211B Gigabit ethernet transceiver */
>> +             phy0: ethernet-phy at 0 {
>
> Hi Linus
>
> ethernet-phy at 1

Thanks for pointing out all these.

Actually it reflects the most stupid bug I was fighting for
several days. After almost giving up I realized reg = <1> for
these PHYs, not reg = 0 ...

The error was still in the unit name.

Fixed this and the other DTS files.

Yours,
Linus Walleij

From: luaraneda@gmail.com (Luis Araneda)
Date: Tue, 1 Aug 2017 22:39:41 -0400
Subject: [PATCH] ARM: dts: sun8i: h3: Enable EMAC with external PHY on
 NanoPi M1 Plus
In-Reply-To: <CAGb2v66r1kpbzKN8uE5pb9mqzWMwTjn-N2ufZGdUU2LJ7FvbeA@mail.gmail.com>
References: <20170801050115.21497-1-luaraneda@gmail.com>
 <CAGb2v66r1kpbzKN8uE5pb9mqzWMwTjn-N2ufZGdUU2LJ7FvbeA@mail.gmail.com>
Message-ID: <CAHbBuxon0L-TPOYpzYEVtFf4pEGsLLFxNPSGgh6t3mooWFXgDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 1, 2017 at 3:55 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Aug 1, 2017 at 1:01 PM, Luis Araneda <luaraneda@gmail.com> wrote:
>> +&emac {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&emac_rgmii_pins>;
>> +       phy-supply = <&reg_gmac_3v3>;
>> +       phy-handle = <&ext_rgmii_phy>;
>> +       phy-mode = "rgmii";
>> +       allwinner,leds-active-low;
>
> This property is for the internal PHY. You should not be using it
> with an external PHY.

You're right. When reading the file "dwmac-sun8i.txt" I thought EPHY meant
External PHY, but it means Ethernet PHY (integrated).
I've tested the board without the property and the LEDs are working fine.

>
>> +       status = "okay";
>> +};
>> +
>> +&mdio {
>> +       ext_rgmii_phy: ethernet-phy at 1 {
>> +               compatible = "ethernet-phy-ieee802.3-c22";
>> +               reg = <0>;
>
> Value in reg should match the address part of the node name.

Ok.

I'll be sending a v2 with the suggested changes.

Cheers,

Luis Araneda.

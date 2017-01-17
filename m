From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 18 Jan 2017 00:57:08 +0800
Subject: [PATCH 1/4] phy: sun4i-usb: support PHY0 on H3 in MUSB mode
In-Reply-To: <20170117080611.tn7s7ddj2csqr27m@lukather>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
 <20170116191449.50397-2-icenowy@aosc.xyz>
 <20170117080611.tn7s7ddj2csqr27m@lukather>
Message-ID: <3866431484672228@web20j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



17.01.2017, 16:06, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Tue, Jan 17, 2017 at 03:14:46AM +0800, Icenowy Zheng wrote:
>> ?The PHY0 on H3 can be wired either to MUSB controller or OHCI/EHCI
>> ?controller.
>>
>> ?The original driver wired it to OHCI/EHCI controller; however, as the
>> ?code to use PHY0 as OHCI/EHCI is missing, it makes the PHY fully
>> ?unusable.
>>
>> ?Rename the register (according to its function and the name in BSP
>> ?driver), and remove the code which wires the PHY0 to OHCI/EHCI, as MUSB
>> ?can support both peripheral and host mode (although the host mode of
>> ?MUSB is buggy).
>
> Can you elaborate on that? What's wrong with it?

The configuration is at bit 0 of register 0x20 in PHY.

When the PHY is reseted, it defaults as MUSB mode.

However, the original author of the H3 PHY code seems to be lack of this
knowledge (He named it PHY_UNK_H3), and changed the PHY to HCI mode.

I just removed the code that wires it to HCI mode, thus it will work in MUSB
mode, with my sun8i-h3-musb patch.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

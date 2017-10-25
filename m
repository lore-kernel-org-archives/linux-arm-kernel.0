From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Oct 2017 12:32:37 +0200
Subject: [PATCH RESEND] phy: rcar-gen2: Add r8a7743/5 support
In-Reply-To: <87211738-8d65-32c0-fb6b-dc2cd395016a@ti.com>
References: <1507544543-28654-1-git-send-email-biju.das@bp.renesas.com>
 <bcfa1e90-c497-ee29-687d-9f9a04ce2d4b@ti.com>
 <87211738-8d65-32c0-fb6b-dc2cd395016a@ti.com>
Message-ID: <CAMuHMdUWtJvYsW3gaCr=Wh-tEauO6E=ue95MK0DXYJFb7c-OJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KIshon,

On Wed, Oct 25, 2017 at 12:30 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On Wednesday 18 October 2017 05:10 PM, Kishon Vijay Abraham I wrote:
>> On Monday 09 October 2017 03:52 PM, Biju Das wrote:
>>> Add USB PHY support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5)
>>> USB PHY is identical to the R-Car Gen2 family.
>>>
>>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> merged, thanks!
>
> just realized $subject is misleading since this is only dt-binding patch. Do
> you plan to send the driver patch too?

There's no need to update the driver, as it matches against the generic fallback
compatible value "renesas,rcar-gen2-usb-phy".

>>> ---
>>> This patch is tested against Linux next tag next-20170929.
>>>
>>>  Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>>> index 91da947..eeb9e18 100644
>>> --- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>>> +++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>>> @@ -4,10 +4,13 @@ This file provides information on what the device node for the R-Car generation
>>>  2 USB PHY contains.
>>>
>>>  Required properties:
>>> -- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
>>> +- compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
>>> +          "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
>>> +          "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
>>>            "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
>>>            "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
>>> -          "renesas,rcar-gen2-usb-phy" for a generic R-Car Gen2 compatible device.
>>> +          "renesas,rcar-gen2-usb-phy" for a generic R-Car Gen2 or
>>> +                                      RZ/G1 compatible device.
>>>
>>>            When compatible with the generic version, nodes must list the
>>>            SoC-specific version corresponding to the platform first

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

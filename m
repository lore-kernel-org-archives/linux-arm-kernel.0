From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 2 Jun 2017 21:14:37 +0200
Subject: [PATCH v2 0/2] Meson8 USB PHY support
In-Reply-To: <02656f9a-33d8-c009-7785-a6bd7d4b2617@ti.com>
References: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
 <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
 <02656f9a-33d8-c009-7785-a6bd7d4b2617@ti.com>
Message-ID: <CAFBinCCvxw413cQLkniUKD_fXQ-eSfNoGcc4VdWXK-0NiXhRYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Thu, Jun 1, 2017 at 3:12 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Saturday 20 May 2017 07:42 PM, Martin Blumenstingl wrote:
>> The USB2 PHY in the Meson8 SoCs is identical to the one in the Meson8b
>> and GXBB SoCs.
>> This series adds a new compatible string for Meson8 and adjusts the
>> Kconfig and MODULE_DESCRIPTION documentation as well as the dt-bindings
>> accordingly.
>>
>> With some additional work the same driver could be used to add USB2
>> support to Meson6 SoCs as well. However, due to lack of a clock
>> controller driver for Meson6 and the lack of a board Meson6 support
>> is not part of this series (Meson6 uses internal mux and divider clocks
>> which are provided by the USB2 PHY registers, while the newer SoCs seem
>> to use an alternative clock called "clk_32k_altsel")
>
> merged, thanks.
thank you!

I have one question though:
you merged two of my patches, both from different series though!
currently part of your tree are:
- "Documentation: dt-bindings: Add documentation for the Meson GXL USB2 PHY" [0]
- "phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs" [1]

the dt-bindings patch is for a new driver, while the meson8b-usb2
patch updates an existing driver.
still missing are the following two patches:
- "phy: meson: add USB2 PHY support for Meson GXL and GXM" [2] (the
actual driver for the dt-bindings from patch [0])
- "dt-bindings: phy: meson8b-usb2-phy: add support for the Meson8
SoCs" [3] (the dt-bindings update related to meson8b-usb2 driver / the
patch from [1])

taking the dt-bindings patch for the meson8b-usb2-phy driver should be trivial.
you also reviewed the new GXL and GXM PHY driver and gave your "OK" on
v3 (I linked v4 below because that one is rebased so it applies after
the phy driver restructuring), see [4]

> -Kishon
>>
>>
>> Changes since v1:
>> - split the dt-bindings and the driver changes into separate patches
>> - rebased to apply on top of my other series "Meson GXL USB2 PHY driver"
>>   (from [0]) which means that this also applies on top of "phy: Group
>>   vendor specific phy drivers"
>> - also update the Kconfig option name (instead of just the description)
>>
>>
>> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-May/003664.html
>>
>>
>> Martin Blumenstingl (2):
>>   phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs
>>   dt-bindings: phy: meson8b-usb2-phy: add support for the Meson8 SoCs
>>
>>  Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt | 3 ++-
>>  drivers/phy/amlogic/Kconfig                                | 6 +++---
>>  drivers/phy/amlogic/phy-meson8b-usb2.c                     | 5 +++--
>>  3 files changed, 8 insertions(+), 6 deletions(-)
>>


Regards,
Martin

[0] https://patchwork.kernel.org/patch/9738625/
[1] https://patchwork.kernel.org/patch/9738635/
[2] https://patchwork.kernel.org/patch/9738631/
[3] https://patchwork.kernel.org/patch/9738637/
[4] http://lists.infradead.org/pipermail/linux-amlogic/2017-May/003500.html

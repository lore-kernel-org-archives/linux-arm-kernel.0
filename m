From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 20 Sep 2017 10:29:58 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gxm: Add support for Khadas VIM2
In-Reply-To: <CAFBinCD0ev5kY_5BY-fZ=fEZ7ZkKi7PdvO4NGAwzVxLEfOT=Dw@mail.gmail.com>
References: <1505832820-3517-1-git-send-email-narmstrong@baylibre.com>
 <1505832820-3517-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCD0ev5kY_5BY-fZ=fEZ7ZkKi7PdvO4NGAwzVxLEfOT=Dw@mail.gmail.com>
Message-ID: <84171990-f5f2-d7d2-2bf6-d28390daac4a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2017 07:55 PM, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Sep 19, 2017 at 4:53 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> The Khadas VIM2 is a Single Board Computer, respin of the origin
>> Khadas VIM board, using an Amlogic S912 SoC and more server oriented.
>>
>> It provides the same external connectors and header pinout, plus a SPI
>> NOR Flash, a reprogrammable STM8S003 MCU, FPC Connector, Cooling FAN header
>> and Pogo Pads Arrays.
>>
>> Cc: Gouwa <gouwa@szwesion.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>>  .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     | 401 +++++++++++++++++++++
>>  3 files changed, 403 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
>>

[...]

>> +&external_mdio {
>> +       external_phy: ethernet-phy at 1 {
>> +               compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
> could you please remove the compatible property and replace it with a
> comment as explained in [0]?
> 

Ok

>> +               reg = <0>;
>> +               max-speed = <1000>;
>> +       };
>> +};
>> +

[...]

> 
> with that and Jerome's comments fixed:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> 
> Regards,
> Martin
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-September/004729.html
> 

Thanks Martin !

I'll send a v2 when eMMC DTS patches goes in 4.14-rc2.

Neil

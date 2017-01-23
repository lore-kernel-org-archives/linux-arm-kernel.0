From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 08:01:01 -0600
Subject: [PATCH 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
In-Reply-To: <1485167232.3082.9.camel@phytec.de>
References: <1484831270-7251-1-git-send-email-t.remmet@phytec.de>
 <20170121205345.oij67ai5d7q7k74d@rob-hp-laptop>
 <1485167232.3082.9.camel@phytec.de>
Message-ID: <CAL_JsqKV6dqZpSouiUHmy6nF-cL2U08_jOAzdWByF4HBmPS_5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 4:27 AM, Teresa Remmet <t.remmet@phytec.de> wrote:
> Hello Rob,
>
> Am Samstag, den 21.01.2017, 14:53 -0600 schrieb Rob Herring:
>> On Thu, Jan 19, 2017 at 02:07:48PM +0100, Teresa Remmet wrote:
>> >
>> > The phyCORE-AM335x development kit is a combination of the
>> > phyCORE-AM335x SoM and a PCM-953 carrier board. The features
>> > of the PCM-953 are:
>> > * ETH phy on carrier board: 1x RGMII
>> > * 1x CAN
>> > * Up to 4x UART
>> > * USB0 (otg)
>> > * USB1 (host)
>> > * SD slot
>> > * User gpio-keys
>> > * User LEDs
>> >
>> > Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
>> > Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
>> > ---
>> >  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>> >  arch/arm/boot/dts/Makefile                         |   1 +
>> >  arch/arm/boot/dts/am335x-pcm-953.dtsi              | 303
>> > +++++++++++++++++++++
>> >  arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
>> >  4 files changed, 334 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
>> >  create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
>> [...]
>>
>> >
>> > +   user_leds: user_leds {
>> > +           compatible = "gpio-leds";
>> > +   };
>> > +
>> > +   user_buttons: user_buttons {
>> > +           compatible = "gpio-keys";
>> > +   };
>> With only a compatible, I don't think there's much gain to split
>> these 2
>> nodes. Otherwse,
>
> whould it be ok to open up the root node again below? Or should I
> better move the nodes up? Which does mess up the order then. We
> orinented here on the am335x-pepper.dts. They also only keep the
> compatibles in the root node.

The order is not important. It is silly to have the same node twice in
the same file. Someone should fix am335x-pepper.dts, too.

The split is generally what is chip specific and board specific, but
this is all board specific.

Rob

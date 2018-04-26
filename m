From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 26 Apr 2018 08:46:14 -0500
Subject: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B83109E5B1@BMK019S01.emtrion.local>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
 <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180420125108.14197-6-jan.tuerk@emtrion.com> <20180423084454.GZ25429@dragon>
 <95F51F4B902CAC40AF459205F6322F01B83109E5B1@BMK019S01.emtrion.local>
Message-ID: <CAL_JsqJ8TO+FadZraUNcCH6swTmwpWjdP5jV2JcoJT1Uf5Sw8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 3:32 AM, T?rk, Jan <Jan.Tuerk@emtrion.de> wrote:
>> -----Urspr?ngliche Nachricht-----
>> Von: Shawn Guo Gesendet: Montag, 23. April 2018 10:45
>> Re: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
>>
>> On Fri, Apr 20, 2018 at 02:50:52PM +0200, jan.tuerk at emtrion.com wrote:
>> > From: Jan Tuerk <jan.tuerk@emtrion.com>
>> >
>> > This patch adds support for the emtrion GmbH emCON-MX6 modules.
>> > They are available with imx.6 Solo, Dual-Lite, Dual and Quad equipped
>> > with Memory from 512MB to 2GB (configured by U-Boot).
>> >
>> > Our default developer-Kit ships with the Avari baseboard and the EDT
>> > ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).
>> >
>> > The devicetree is split into the common part providing all module
>> > components and the basic support for all SoC versions
>> > (imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
>> > Finally the support for the avari baseboard in the developer-kit
>> > configuration is provided by the emcon-avari dts files.
>> >
>> > Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
>> > ---
>> >  Documentation/devicetree/bindings/arm/emtrion.txt |  13 +
>>
>> It's better to have a separate patch for bindings doc, which needs to be
>> acknowledged by DT maintainers.
>
> I can change that, but nobody complained in the first 2 revisions of the patch.

Well, sometimes I forget to mention what is step 1 in
Documentation/devicetree/bindings/submitting-patches.txt.

> Also I though having the documentation is required for merging new bindings?

Yes, so binding patches come first (step 3).

>> >  arch/arm/boot/dts/Makefile                        |   2 +
>> >  arch/arm/boot/dts/imx6dl-emcon-avari.dts          | 224 ++++++
>> >  arch/arm/boot/dts/imx6dl-emcon.dtsi               |  27 +
>> >  arch/arm/boot/dts/imx6q-emcon-avari.dts           | 224 ++++++
>> >  arch/arm/boot/dts/imx6q-emcon.dtsi                |  27 +
>> >  arch/arm/boot/dts/imx6qdl-emcon.dtsi              | 838
>> ++++++++++++++++++++++
>> >  7 files changed, 1355 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
>> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
>> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
>> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
>> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
>> >  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

[...]

>> > +   };
>> > +
>> > +   boardID: pca8754a at 3a {
>>
>> Please find a more generic node name for it.
>
> you mean boardID at 3a?

No. "gpio at 3a" as it is a gpio controller.

> This chip identifies the baseboard type for the bootloader.
>
>>
>> > +           compatible = "nxp,pca8574";
>> > +           reg = <0x3a>;
>> > +           gpio-controller;
>> > +           #gpio-cells = <1>;
>> > +   };

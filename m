From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 7 Sep 2018 09:43:29 +0530
Subject: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
In-Reply-To: <20180905075056.tob7itg3judccooe@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
 <20180905075056.tob7itg3judccooe@flea>
Message-ID: <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 1:20 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 12:40:50PM +0800, Icenowy Zheng wrote:
>> +             hdmi_phy: hdmi-phy at 1ef0000 {
>> +                     compatible = "allwinner,sun8i-h3-hdmi-phy";
>> +                     reg = <0x01ef0000 0x10000>;
>> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>> +                              <&ccu 7>;
>> +                     clock-names = "bus", "mod", "pll-0";
>> +                     resets = <&ccu RST_BUS_HDMI0>;
>> +                     reset-names = "phy";
>> +                     #phy-cells = <0>;
>> +             };
>
> This needs to use the bindings we have for that phy.

You mean allwinner,sun50i-a64-hdmi-phy ?

From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 14 May 2018 14:03:36 +0530
Subject: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
In-Reply-To: <20180502113413.vv2r3ubfoh7gm3ms@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
 <20180502113413.vv2r3ubfoh7gm3ms@flea>
Message-ID: <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 5:04 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
>> +             hdmi_phy: hdmi-phy at 1ef0000 {
>> +                     compatible = "allwinner,sun50i-a64-hdmi-phy",
>> +                                  "allwinner,sun8i-h3-hdmi-phy";
>> +                     reg = <0x01ef0000 0x10000>;
>> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>> +                              <&ccu CLK_PLL_VIDEO1>;
>
> You were discussing that the PLL0 could also be used to clock the PHY,
> has that been figured out?

This is what I understand from Fig: 3-3. Module Clock Diagram, both
tcon0 and tcon1 are using HDMI. I'm thinking based on the tcon
configuration we need use proper PLL or some logic to get common PLL
don't know yet. Since this series adding tcon1 I've attached PLL1.

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.

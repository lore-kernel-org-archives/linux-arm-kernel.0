From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 14 May 2018 10:40:50 +0200
Subject: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
In-Reply-To: <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
 <20180502113413.vv2r3ubfoh7gm3ms@flea>
 <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
Message-ID: <20180514084050.ix5corfuvx33gsyn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 02:03:36PM +0530, Jagan Teki wrote:
> On Wed, May 2, 2018 at 5:04 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> >> +             hdmi_phy: hdmi-phy at 1ef0000 {
> >> +                     compatible = "allwinner,sun50i-a64-hdmi-phy",
> >> +                                  "allwinner,sun8i-h3-hdmi-phy";
> >> +                     reg = <0x01ef0000 0x10000>;
> >> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> >> +                              <&ccu CLK_PLL_VIDEO1>;
> >
> > You were discussing that the PLL0 could also be used to clock the PHY,
> > has that been figured out?
> 
> This is what I understand from Fig: 3-3. Module Clock Diagram, both
> tcon0 and tcon1 are using HDMI. I'm thinking based on the tcon
> configuration we need use proper PLL or some logic to get common PLL
> don't know yet. Since this series adding tcon1 I've attached PLL1.

You're not describing the TCON node here though, but the HDMI one, and
the HDMI block is listed in both the PLL video 0 and 1.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/63d5d7fa/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 16:27:37 +0200
Subject: [PATCH 11/12] ARM: dts: sun8i: Add i2c controller nodes
In-Reply-To: <CAGb2v67NwsJORoFrgEECDtexXGtF5qOx7NX1PVpZHkjVs-mG2A@mail.gmail.com>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
 <1408247538-16950-12-git-send-email-wens@csie.org>
 <20140817080204.GY15297@lukather>
 <CAGb2v67NwsJORoFrgEECDtexXGtF5qOx7NX1PVpZHkjVs-mG2A@mail.gmail.com>
Message-ID: <20140818142737.GC15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 11:20:44PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, Aug 17, 2014 at 4:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sun, Aug 17, 2014 at 11:52:17AM +0800, Chen-Yu Tsai wrote:
> >> Add nodes for the 3 i2c controllers found on A23 SoCs to the sun8i DTSI.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun8i-a23.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
> >> index 4658998..53ef350 100644
> >> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> >> @@ -387,6 +387,42 @@
> >>                       status = "disabled";
> >>               };
> >>
> >> +             i2c0: i2c at 01c2ac00 {
> >> +                     compatible = "allwinner,sun6i-a31-i2c";
> >> +                     reg = <0x01c2ac00 0x400>;
> >> +                     interrupts = <0 6 4>;
> >> +                     clocks = <&apb2_gates 0>;
> >> +                     clock-frequency = <100000>;
> >
> > It's the default, you don't need to set it.
> 
> Ah, just checked the driver, it is indeed the default.
> All the other sunxi dtsi have it though. Do we want to be consistent?

Yep, it's usually a good thing :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/66fc8503/attachment.sig>

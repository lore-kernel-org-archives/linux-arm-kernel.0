From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 21:33:13 +0200
Subject: [linux-sunxi] [PATCH 2/4] ARM: dts: sun8i: Add PWM channel 0
 pinmux setting for A23/A33
In-Reply-To: <CAGb2v641pqeop4H3z8i=Pe_HY5u0kYFX8wMNyeQ_BuAKkN0bpw@mail.gmail.com>
References: <1442561739-6824-1-git-send-email-wens@csie.org>
 <1442561739-6824-3-git-send-email-wens@csie.org>
 <55FC2E31.3060007@redhat.com>
 <CAGb2v641pqeop4H3z8i=Pe_HY5u0kYFX8wMNyeQ_BuAKkN0bpw@mail.gmail.com>
Message-ID: <20150918193313.GU4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 12:18:04AM +0800, Chen-Yu Tsai wrote:
> On Fri, Sep 18, 2015 at 11:30 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> > On 09/18/2015 03:35 AM, Chen-Yu Tsai wrote:
> >>
> >> The PWM controller has 2 outputs, with one usable pin for each.
> >>
> >> Add a pinmux setting for the first channel. This is often used
> >> for backlight dimming on tablets.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>   arch/arm/boot/dts/sun8i-a23-a33.dtsi | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> >> b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> >> index e7054304018a..8f4db82084c5 100644
> >> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> >> @@ -412,6 +412,13 @@
> >>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>                         };
> >>
> >> +                       pwm0_pins: pwm0 {
> >
> >
> > This should be "pwm0_pins_a: pwm0 at 0" so as to be consistent with the a10 /
> > a20 dtsi
> > files.
> 
> This is the only possible setting. I do not see why we need "_a" for the
> label and "@0" for the name. IMHO they are used to avoid name clashes when
> there are multiple possible pinmux settings.

Yep, sounds reasonable, I applied the patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/1d94b67b/attachment.sig>

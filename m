From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Apr 2017 08:53:43 +0200
Subject: [PATCH 2/3] ARM: sun8i: a83t: Drop leading zeroes from device
 node addresses
In-Reply-To: <CAGb2v664r+Wt9zrSK2GudMYRkp9N+QpdbEMdWEobx-HxS38Ovw@mail.gmail.com>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-3-wens@csie.org>
 <20170418090329.odixwybrkqvp2o7z@lukather>
 <CAGb2v664r+Wt9zrSK2GudMYRkp9N+QpdbEMdWEobx-HxS38Ovw@mail.gmail.com>
Message-ID: <20170419065343.4lyfzf66z47tu3b4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:22:02PM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 18, 2017 at 5:03 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Apr 18, 2017 at 12:22:04PM +0800, Chen-Yu Tsai wrote:
> >> Kbuild now complains about leading zeroes in the address portion of
> >> device node names.
> >>
> >> Get rid of them.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun8i-a83t.dtsi | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> >> index 913aacafe8d5..82cb87f21b96 100644
> >> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> >> @@ -162,7 +162,7 @@
> >>               #size-cells = <1>;
> >>               ranges;
> >>
> >> -             pio: pinctrl at 01c20800 {
> >> +             pio: pinctrl at 1c20800 {
> >
> > As far as I know this breaks Uboot's auto-addition of stdout-path
> 
> You're right. It breaks as Uboot has the path to the uarts hard-coded.
> That sucks. And from what I can tell, it's not easily solvable by just
> switching to serial alias based references. CONS_INDEX won't line up
> on the A23/A33 Q8 tablets.
> 
> Maybe we can just keep the uart device node the same for now, but fix
> all the other ones. We can come back and fix the uart later once we
> figure out how to fix Uboot.

Thinking more about this, I don't really know why we have that in
U-Boot actually. All our DTs for a very long time have had stdout-path
properly set (and if it's improperly set, this should be fixed). I'd
say we can simply remove that from U-Boot and be done with it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170419/38858818/attachment.sig>

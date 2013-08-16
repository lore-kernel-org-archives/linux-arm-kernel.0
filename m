From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 16 Aug 2013 09:48:28 +0200
Subject: [PATCH V5] ARM: dts: Change i2s compatible string on exynos5250
In-Reply-To: <CAOesGMj4y=uVMmETLXs_1ZfTD+CrQgKuirrpGrqs=CU3uk5__Q@mail.gmail.com>
References: <1376627178-28649-1-git-send-email-padma.v@samsung.com>
 <CAOesGMj4y=uVMmETLXs_1ZfTD+CrQgKuirrpGrqs=CU3uk5__Q@mail.gmail.com>
Message-ID: <2100011.uIh4j153YZ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thursday 15 of August 2013 21:48:32 Olof Johansson wrote:
> On Thu, Aug 15, 2013 at 9:26 PM, Padmavathi Venna <padma.v@samsung.com> 
wrote:
> > This patch removes quirks from i2s node and change the i2s
> > compatible names.
> > 
> > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> > ---
> > 
> > Changes since V4:
> >         - Mark Brown reverted the below two patches due to below build
> >         failure with>         
> >           exynos_defconfig.
> >           
> >                 "ARM: dts: exynos5250: move common i2s properties to
> >                 exynos5 dtsi"
> >                 "ARM: dts: Change i2s compatible string on exynos5250"
> >           
> >           build error:
> >           DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
> >           ERROR (phandle_references): Reference to non-existent node
> >           or label "pdma1" ERROR (phandle_references): Reference to
> >           non-existent node or label "pdma1" ERROR
> >           (phandle_references): Reference to non-existent node or
> >           label "pdma0" ERROR (phandle_references): Reference to
> >           non-existent node or label "pdma0"> 
> > But with out "ARM: dts: Change i2s compatible string on exynos5250"
> > will break the i2s driver.
> > 
> > So posting this patch now and will take care of posting other patch
> > later after dependent patches got merged.
> > 
> >  arch/arm/boot/dts/exynos5250.dtsi |    9 +++------
> >  1 files changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> > b/arch/arm/boot/dts/exynos5250.dtsi index ef57277..376090f 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -405,7 +405,7 @@
> > 
> >         };
> >         
> >         i2s0: i2s at 03830000 {
> > 
> > -               compatible = "samsung,i2s-v5";
> > +               compatible = "samsung,s5pv210-i2s";
> 
> Device tree reviewers, this is something to look out for in the
> future. Some samsung platforms/drivers use "samsung,<chip>-<ip>",
> others "samsung,<ip>-<chip>". I don't personally care much one way or
> another, but it really should be consistent.

Hmm, I just did a quick git grep over arch/arm/boot/dts and could not 
really find the "samsung,<ip>-<chip>" pattern.

Except MFC (and without Padma's patch also I2S), which used "samsung,<ip>-
<ip version>, all the compatible values I can see are based on 
"samsung,<chip>-<ip>" pattern.

I believe we discussed this issue several times already and finally agreed 
to use "samsung,<chip>-<ip>" for any new compatible values.

Best regards,
Tomasz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/c5653333/attachment.sig>

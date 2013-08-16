From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 16 Aug 2013 09:53:23 +0200
Subject: [PATCH V5] ARM: dts: Change i2s compatible string on exynos5250
In-Reply-To: <13f801ce9a43$823571b0$86a05510$@org>
References: <1376627178-28649-1-git-send-email-padma.v@samsung.com>
 <CAOesGMj4y=uVMmETLXs_1ZfTD+CrQgKuirrpGrqs=CU3uk5__Q@mail.gmail.com>
 <13f801ce9a43$823571b0$86a05510$@org>
Message-ID: <1812843.09c8C6xn0E@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Friday 16 of August 2013 14:43:17 Kukjin Kim wrote:
> Olof Johansson wrote:
> > On Thu, Aug 15, 2013 at 9:26 PM, Padmavathi Venna
> > <padma.v@samsung.com>
> > 
> > wrote:
> > > This patch removes quirks from i2s node and change the i2s
> > > compatible names.
> > > 
> > > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> > > ---
> > > 
> > > Changes since V4:
> > >         - Mark Brown reverted the below two patches due to below
> > >         build
> > 
> > failure with
> > 
> > >           exynos_defconfig.
> > >           
> > >                 "ARM: dts: exynos5250: move common i2s properties to
> 
> exynos5
> 
> > dtsi"
> > 
> > >                 "ARM: dts: Change i2s compatible string on
> > >                 exynos5250"
> > >           
> > >           build error:
> > >           DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
> > >           ERROR (phandle_references): Reference to non-existent node
> > >           or
> > 
> > label "pdma1"
> > 
> > >           ERROR (phandle_references): Reference to non-existent node
> > >           or
> > 
> > label "pdma1"
> > 
> > >           ERROR (phandle_references): Reference to non-existent node
> > >           or
> > 
> > label "pdma0"
> > 
> > >           ERROR (phandle_references): Reference to non-existent node
> > >           or
> > 
> > label "pdma0"
> > 
> > > But with out "ARM: dts: Change i2s compatible string on exynos5250"
> > > will> 
> > break the i2s
> > 
> > > driver.
> > > 
> > > So posting this patch now and will take care of posting other patch
> > 
> > later after dependent
> > 
> > > patches got merged.
> > > 
> > >  arch/arm/boot/dts/exynos5250.dtsi |    9 +++------
> > >  1 files changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> > 
> > b/arch/arm/boot/dts/exynos5250.dtsi
> > 
> > > index ef57277..376090f 100644
> > > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > > @@ -405,7 +405,7 @@
> > > 
> > >         };
> > >         
> > >         i2s0: i2s at 03830000 {
> > > 
> > > -               compatible = "samsung,i2s-v5";
> > > +               compatible = "samsung,s5pv210-i2s";
> > 
> > Device tree reviewers, this is something to look out for in the
> > future. Some samsung platforms/drivers use "samsung,<chip>-<ip>",
> > others "samsung,<ip>-<chip>". I don't personally care much one way or
> > another, but it really should be consistent.
> 
> Hmm...I think, if "samsung,<ip name>-<ip version>" is possible, it would
> be nice. I remember there are no versions in datasheet for some IPs but
> something have like i2s and mfc. So "samsung,<ip>-<version>" is used
> for only i2s and mfc. But actually there are versions for Samsung IPs,
> no comments for that in datasheet. So I think, if Samsung can provide
> the specific version of Samsung IPs, we can use that like other
> platforms. I will prepare some table for that after meeting with
> Samsung hardware IP team so that samsung platform use one format
> "samsung,<ip>-<version>".

Sorry, I don't think this is a good idea, unless you can force the IP team 
to release a version table containing version of _every_ IP for _every_ 
released SoC, including those historical ones, like S3C24xx and S3C64xx. 
Of course such tables should be available publicly.

In addition, there might be other funny things going on with IPs and their 
surroundings, that could make a need to create several separate compatible 
values for the same IP revision, but on different SoCs, because it was 
integrated in a slightly different way.

I believe we have choses the "samsung,<chip>-<ip>" scheme to avoid being 
dependent upon data that is not always publicly available, which is more 
future- (and past-) proof and also solves the integration problem.

Best regards,
Tomasz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/bcd090e8/attachment.sig>

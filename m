From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 03 Apr 2013 10:46:08 +0900
Subject: [PATCH] ARM: dts: add usb 2.0 clock references to exynos5250
 device tree
In-Reply-To: <CAFp+6iFXd-4uFfc4v_kWf_FTBmeHkNwsEV0QoyHCzza8evgd9A@mail.gmail.com>
References: <1363195099-15919-1-git-send-email-dianders@chromium.org>
 <006301ce211d$a6caa670$f45ff350$%han@samsung.com>
 <CAFp+6iFXd-4uFfc4v_kWf_FTBmeHkNwsEV0QoyHCzza8evgd9A@mail.gmail.com>
Message-ID: <24ae01ce300d$037af160$0a70d420$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vivek Gautam wrote:
> 
> Hi,
> 
> 
> On Fri, Mar 15, 2013 at 7:07 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> >
> > On Thursday, March 14, 2013 2:18 AM, Doug Anderson wrote:
> >>
> >> This is a fixup to two device tree nodes that have already landed but
> >> without clock nodes since the transition to common clock happened at
> >> the same time.
> >>
> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
> >
> > The clock number and name are right.
> >
> > Reviewed-by: Jingoo Han <jg1.han@samsung.com>
> >
> >
> > Best regards,
> > Jingoo Han
> >
> >> ---
> >>  arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> >> index 24c52e6..59be603 100644
> >> --- a/arch/arm/boot/dts/exynos5250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> >> @@ -402,12 +402,18 @@
> >>               compatible = "samsung,exynos4210-ehci";
> >>               reg = <0x12110000 0x100>;
> >>               interrupts = <0 71 0>;
> >> +
> >> +             clocks = <&clock 285>;
> >> +             clock-names = "usbhost";
> >>       };
> >>
> >>       usb at 12120000 {
> >>               compatible = "samsung,exynos4210-ohci";
> >>               reg = <0x12120000 0x100>;
> >>               interrupts = <0 71 0>;
> >> +
> >> +             clocks = <&clock 285>;
> >> +             clock-names = "usbhost";
> 
> tested this patch with smdk5250 h/w.
> 
> Tested-by: Vivek Gautam <gautam.vivek@samsung.com>
> 
Vivek and Jingoo,

Thanks for your review and test.

Looks good to me and I applied in my local.
Just note that this should be seen in my public tree tomorrow night(KST).

- Kukjin

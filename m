From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 31 Mar 2015 15:54:05 +0900
Subject: [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc instead of
 exynos3250-rtc
In-Reply-To: <CABxcv=nDca+B1cpZ3d6PhLmpU-RuFgjGZiNCX5X2HivdAPnt-g@mail.gmail.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
 <5519DE76.4080803@samsung.com>
 <CABxcv=nDca+B1cpZ3d6PhLmpU-RuFgjGZiNCX5X2HivdAPnt-g@mail.gmail.com>
Message-ID: <063901d06b7f$7a72d8f0$6f588ad0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> On Tue, Mar 31, 2015 at 1:38 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > On 03/31/2015 12:19 AM, Krzysztof Kozlowski wrote:
> >> Mark "samsung,exynos3250-rtc" compatible as deprecated because it
> >> duplicates the "samsung,s3c6410-rtc". Use "samsung,s3c6410-rtc" on
> >> Exynos3250 and Exynos4415 boards.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> ---
> >>  Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 3 ++-
> >>  arch/arm/boot/dts/exynos3250.dtsi                 | 2 +-
> >>  arch/arm/boot/dts/exynos4415.dtsi                 | 2 +-
> >>  3 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> index ab757b84daa7..ac2fcd6ff4b8 100644
> >> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> >> @@ -6,7 +6,8 @@ Required properties:
> >>      * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
> >>      * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
> >>      * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
> >> -    * "samsung,exynos3250-rtc" - for controllers compatible with exynos3250 rtc.
> >> +    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
> >> +                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
> >>  - reg: physical base address of the controller and length of memory mapped
> >>    region.
> >>  - interrupts: Two interrupt numbers to the cpu should be specified. First
> >> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> >> index e3bfb11c6ef8..8d58b550e925 100644
> >> --- a/arch/arm/boot/dts/exynos3250.dtsi
> >> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> >> @@ -189,7 +189,7 @@
> >>               };
> >>
> >>               rtc: rtc at 10070000 {
> >> -                     compatible = "samsung,exynos3250-rtc";
> >> +                     compatible = "samsung,s3c6410-rtc";
> >>                       reg = <0x10070000 0x100>;
> >>                       interrupts = <0 73 0>, <0 74 0>;
> >>                       interrupt-parent = <&pmu_system_controller>;
> >> diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
> >> index 5caea996e090..186cb8465683 100644
> >> --- a/arch/arm/boot/dts/exynos4415.dtsi
> >> +++ b/arch/arm/boot/dts/exynos4415.dtsi
> >> @@ -177,7 +177,7 @@
> >>               };
> >>
> >>               rtc: rtc at 10070000 {
> >> -                     compatible = "samsung,exynos3250-rtc";
> >> +                     compatible = "samsung,s3c6410-rtc";
> >>                       reg = <0x10070000 0x100>;
> >>                       interrupts = <0 73 0>, <0 74 0>;
> >>                       status = "disabled";
> >>
> >
> > Looks good to me.
> >
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >
> > Thanks,
> > Chanwoo Choi
> > --
> 
> Looks good to me also.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
Thanks, applied.

- Kukjin

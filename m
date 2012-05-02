From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 May 2012 12:55:53 -0700
Subject: [PATCH 18/20] ARM: dts: Update device tree source files for
 EXYNOS5250
In-Reply-To: <1335813270-13083-19-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-19-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAOesGMiSrNoOA5wTEZo4RiZkPvSAMi43CntN6GUepTzx6M++OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 30, 2012 at 12:14 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> Updated EXYNOS5 device tree source files to reflect changes in rev1
> of EXYNOS5 SoC. This includes new additions to the EXYNOS5 dtsi and
> SMDK5250 dts files and few minor fixes.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/boot/dts/exynos5250-smdk5250.dts | ? 52 +++++++++++++++++++++++++++++
> ?arch/arm/boot/dts/exynos5250.dtsi ? ? ? ? | ? 44 +++++++-----------------
> ?2 files changed, 65 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 399d17b..bcc4b89 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -23,4 +23,56 @@
> ? ? ? ?chosen {
> ? ? ? ? ? ? ? ?bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
> ? ? ? ?};
> +
> + ? ? ? i2c at 12C60000 {
> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <0>;

Two nits:

#a-c and #s-c is likely to always be 1/0, so you might as well move
these to the dtsi file for the SoC.

Also, we tend to use non-caps here and in other locations (so it
should be 12c60000 here).


-Olof

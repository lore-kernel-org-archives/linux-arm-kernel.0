From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 15 May 2012 19:30:29 +0530
Subject: [PATCH 18/20] ARM: dts: Update device tree source files for
 EXYNOS5250
In-Reply-To: <CAOesGMiSrNoOA5wTEZo4RiZkPvSAMi43CntN6GUepTzx6M++OA@mail.gmail.com>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-19-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMiSrNoOA5wTEZo4RiZkPvSAMi43CntN6GUepTzx6M++OA@mail.gmail.com>
Message-ID: <CAJuYYwTws16QQzimAp4c1T33nW4XapOLtE8mL8p=aRfRp8V28A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2012 01:25, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Mon, Apr 30, 2012 at 12:14 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Updated EXYNOS5 device tree source files to reflect changes in rev1
>> of EXYNOS5 SoC. This includes new additions to the EXYNOS5 dtsi and
>> SMDK5250 dts files and few minor fixes.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> ---
>> ?arch/arm/boot/dts/exynos5250-smdk5250.dts | ? 52 +++++++++++++++++++++++++++++
>> ?arch/arm/boot/dts/exynos5250.dtsi ? ? ? ? | ? 44 +++++++-----------------
>> ?2 files changed, 65 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> index 399d17b..bcc4b89 100644
>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> @@ -23,4 +23,56 @@
>> ? ? ? ?chosen {
>> ? ? ? ? ? ? ? ?bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
>> ? ? ? ?};
>> +
>> + ? ? ? i2c at 12C60000 {
>> + ? ? ? ? ? ? ? #address-cells = <1>;
>> + ? ? ? ? ? ? ? #size-cells = <0>;
>
> Two nits:
>
> #a-c and #s-c is likely to always be 1/0, so you might as well move
> these to the dtsi file for the SoC.

This is fixed.

>
> Also, we tend to use non-caps here and in other locations (so it
> should be 12c60000 here).

The dtsi file uses 'C' instead of 'c'. So any change here in dts file
would require a change in the dtsi file as well. So adding this change
in this patch does not seem correct. So I will not do this change for
now.

Thanks,
Thomas.

>
>
> -Olof

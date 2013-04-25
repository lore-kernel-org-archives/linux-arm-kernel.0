From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 25 Apr 2013 11:13:11 +0200
Subject: [PATCH] ARM: dts: add pinctrl nodes for Exynos5250 SoC
In-Reply-To: <CA+Ln22EafDes5Lrvpwg08HnyNRuo=Z2uHAg6VJDMjNon9=E_qQ@mail.gmail.com>
References: <1355403978-388-1-git-send-email-thomas.abraham@linaro.org>
 <20130424233348.GA6603@quad.lixom.net>
 <CA+Ln22EafDes5Lrvpwg08HnyNRuo=Z2uHAg6VJDMjNon9=E_qQ@mail.gmail.com>
Message-ID: <1915783.V1ojdPclI6@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh screw that mobile GMail - seems like it now always sends plain + HTML...

Resending the post from a mail client working properly:

On Thursday 25 of April 2013 10:47:21 Tomasz Figa wrote:

Hi Olof,

W dniu czwartek, 25 kwietnia 2013 u?ytkownik Olof Johansson <olof@lixom.net> 
napisa?:
> On Thu, Dec 13, 2012 at 06:36:18PM +0530, Thomas Abraham wrote:
>> Add pinctrl device nodes for Exynos5250 SoC.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> Replying to an old email of a patch that has been merged because it seems
> horribly broken.
>

As far as I can see in Kgene's tree, newer version of this patch has been 
merged.

I managed to already found a typo in that new version, though. The pinctrl2 
block is located at 0x3860000 not 0x3680000, or at least this is what the 
manual says.

>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi 
b/arch/arm/boot/dts/exynos5250.dtsi
>> index 581e57a..eb8d610 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -18,6 +18,7 @@
>>  */
>>
>>  /include/ "skeleton.dtsi"
>> +/include/ "exynos5250-pinctrl.dtsi"
>>
>>  / {
>>       compatible = "samsung,exynos5250";
>> @@ -48,6 +49,8 @@
>>               mshc1 = &dwmmc_1;
>>               mshc2 = &dwmmc_2;
>>               mshc3 = &dwmmc_3;
>> +             pinctrl0 = &pinctrl_0;
>> +             pinctrl3 = &pinctrl_3;
>>       };
>>
>>       gic:interrupt-controller at 10481000 {
>> @@ -79,6 +82,24 @@
>>               interrupts = <0 42 0>;
>>       };
>>
>> +     pinctrl_0: pinctrl at 11400000 {
>> +             compatible = "samsung,pinctrl-exynos5250";
>> +             reg = <0x11400000 0x1000>;
>> +             interrupts = <0 46 0>;
>> +
>> +             wakup_eint: wakeup-interrupt-controller {
>> +                     compatible = "samsung,exynos4210-wakeup-eint";
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0 32 0>;
>> +             };
>
> Typo, should be "wakeup_eint". And what happened to #interrupt-cells? And 
the
> interrupt map?
>
> Do you have an example of a tested user or a testcase for this? I'm
> trying to get interrupts going on these pins, and it's not looking like
> it's even close to working.

I have extensively tested interrupt handling in pinctrl-driver when reworking 
it. Testing was done on Exynos4210 and Exynos4412, but Exynos5250 seems to 
follow exactly the same design of pinctrl block.

Could you specify a bit more precisely what is your use case (GPIO pin, 
driver, device tree node of interrupt user, etc.)?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework

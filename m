From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 24 May 2012 14:39:58 +0530
Subject: [PATCH 6/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos5 platforms
In-Reply-To: <006d01cd3981$c8b0d950$5a128bf0$%kim@samsung.com>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-7-git-send-email-thomas.abraham@linaro.org>
 <006d01cd3981$c8b0d950$5a128bf0$%kim@samsung.com>
Message-ID: <CAJuYYwSe0mOF=oUNiaB88fnxn1pHwR=CNVgzrJr9Uw7id-rudQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2012 13:19, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Add device nodes for the three instances of spi controllers in Exynos5
>> platforms and enable instance spi 1 for smdk5250 board.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/boot/dts/exynos5250-smdk5250.dts | ? 47
>> ++++++++++++++++++++++++++++-
>> ?arch/arm/boot/dts/exynos5250.dtsi ? ? ? ? | ? 46
>> ++++++++++++++++++++++++++++
>> ?2 files changed, 92 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> index 49945cc..dca572d 100644
>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>
> [...]
>
>> - ? ? ? ? ? ? bootargs = "root=/dev/ram0 rw ramdisk=8192
>> console=ttySAC1,115200";
>> + ? ? ? ? ? ? bootargs ="root=/dev/ram0 rw ramdisk=8192
>> initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
>
> Yes, we need above. But it should be separated patch from here.

This is mistake. I will remove this from here. Thanks for pointing this out.

>
> [...]
>
>> + ? ? spi_1: spi at 12d30000 {
>> + ? ? ? ? ? ? gpios = <&gpa2 4 2 3 0>,
>> + ? ? ? ? ? ? ? ? ? ? <&gpa2 6 2 3 0>,
>> + ? ? ? ? ? ? ? ? ? ? <&gpa2 7 2 3 0>;
>> +
>> + ? ? ? ? ? ? w25q80bw at 0 {
>> + ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
>> + ? ? ? ? ? ? ? ? ? ? #size-cells = <1>;
>> + ? ? ? ? ? ? ? ? ? ? compatible = "w25x80";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0>;
>> + ? ? ? ? ? ? ? ? ? ? spi-max-frequency = <10000>;
>> +
>> + ? ? ? ? ? ? ? ? ? ? controller-data {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cs-gpio = <&gpa2 5 1 0 3>;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? samsung,spi-feedback-delay = <0>;
>> + ? ? ? ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? ? ? ? partition at 0 {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? label = "U-Boot";
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg = <0x0 0x40000>;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? read-only;
>> + ? ? ? ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? ? ? ? partition at 40000 {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? label = "Kernel";
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg = <0x40000 0xc0000>;
>> + ? ? ? ? ? ? ? ? ? ? };
>> + ? ? ? ? ? ? };
>> + ? ? };
>
> See my previous comments on 5/6.

Yes, there is a onboard spi flash.

>
> [...]
>
>> + ? ? combiner:interrupt-controller at 10440000 {
>> + ? ? ? ? ? ? compatible = "samsung,exynos4210-combiner";
>> + ? ? ? ? ? ? #interrupt-cells = <2>;
>> + ? ? ? ? ? ? interrupt-controller;
>> + ? ? ? ? ? ? samsung,combiner-nr = <32>;
>> + ? ? ? ? ? ? reg = <0x10440000 0x1000>;
>> + ? ? ? ? ? ? interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>> + ? ? };
>
> Already merged above in my tree.

Right. I completely missed this one. I will remove this from here.

Thanks a lot for your review and comments.

Regards,
Thomas.

>
> [...]
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>

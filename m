From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 12 Oct 2015 21:02:29 +0530
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <561B48B7.1040201@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
Message-ID: <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 12 October 2015 at 11:14, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 12.10.2015 00:46, Anand Moon wrote:
>> Added support for UHS-I bus speed 50MB/s (SDR50, DDR50) 104MB/s (SDR104)
>
> This description is not entirely correct. The MMC driver already
> supports these UHS speeds (you did not any code) so you rather enabled
> it (description of bindings says "is supported").
>
> You mentioned DDR50 but I don't see respective property below.
>
> How do you know that these modes are really supported? I don't know. Can
> you convince me?

Setting this DDR50 capability give me this error. That's the reason to
drop this capability.

Sep 24 09:37:04 odroidxu4 kernel: [    4.138418] mmc_host mmc1: Bus
speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ
div = 0)
Sep 24 09:37:04 odroidxu4 kernel: [    4.138546] mmc1: new ultra high
speed DDR50 SDHC card at address aaaa
Sep 24 09:37:04 odroidxu4 kernel: [    4.141585] mmcblk0: mmc1:aaaa
SL32G 29.7 GiB
Sep 24 09:37:04 odroidxu4 kernel: [    4.146477] mmcblk0: error -110
sending status command, retrying
Sep 24 09:37:04 odroidxu4 kernel: [    4.146577] mmcblk0: error -115
sending stop command, original cmd response 0x900, card status 0x900
Sep 24 09:37:04 odroidxu4 kernel: [    4.146581] mmcblk0: error -84
transferring data, sector 0, nr 8, cmd response 0x900, card status 0x0

>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>
>> ---
>> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
>>
>> Changes Fixed the UHS-I bus speed detedtion on cold boot.
>
> I don't get what is exactly fixed here. What was the error? What is the
> outcome of this fix? The log below is before or after?
>
> Best regards,
> Krzysztof
>
>>
>> [    2.439806] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 100000000Hz, actual 100000000HZ div = 0)
>> [    2.449729] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
>> [    2.455984] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>> [    2.461743]  mmcblk0: p1 p2
>
>> ---
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> index 58c06d3..ba4a87b 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> @@ -364,6 +364,10 @@
>>       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>       bus-width = <4>;
>>       cap-sd-highspeed;
>> +     sd-uhs-sdr12;
>> +     sd-uhs-sdr25;
>> +     sd-uhs-sdr50;
>> +     sd-uhs-sdr104;
>>  };
>>
>>  &pinctrl_0 {
>>
>

-Anand Moon

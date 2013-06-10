From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon, 10 Jun 2013 14:48:15 +0530
Subject: [PATCH 04/13] ARM: dts: list the CPU nodes for Exynos5250
In-Reply-To: <20130606165439.GC23311@e106331-lin.cambridge.arm.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
 <20130606165439.GC23311@e106331-lin.cambridge.arm.com>
Message-ID: <CANuQgHHxKNmr_ZUjszKu7XdpaBRJ+5Ky2B7YWreMODb639A5-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 6 June 2013 22:24, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 06, 2013 at 12:01:18PM +0100, Chander Kashyap wrote:
>> Instead of having to specify the number for CPUs in Exynos5250 in platsmp.c
>> file, let the number of CPUs be determined by having this information listed
>> in Exynos5250 device tree file.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi |   14 ++++++++++++++
>>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index e571d3b..7f6b1c7 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -50,6 +50,20 @@
>>               pinctrl3 = &pinctrl_3;
>>       };
>>
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <0>;
>> +             };
>> +             cpu at 1 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <1>;
>> +             };
>> +     };
>> +
>
> It would be nice to have device_type = "cpu" on each of the cpu nodes.
Sure, i will populate the nodes.
thanks.
>
> Thanks,
> Mark.



--
with warm regards,
Chander Kashyap

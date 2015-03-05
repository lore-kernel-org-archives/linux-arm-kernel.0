From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Fri, 6 Mar 2015 01:12:43 +0900
Subject: [PATCH v5 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <20150305122459.GC14093@leverpostej>
References: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
 <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
 <20150305122459.GC14093@leverpostej>
Message-ID: <CAGTfZH3Bf1ueFO25NXFbN+Mvb9TcGbErbSp=a+vQ0=A+E07mQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Mar 5, 2015 at 9:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 05, 2015 at 05:38:23AM +0000, Chanwoo Choi wrote:
>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
>> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
>> PSCI (Power State Coordination Interface) v0.1.
>>
>> This patch includes following dt node to support Exynos5433 SoC:
>> 1. Octa core for big.LITTLE architecture
>> - Cortex-A53 LITTLE Quad-core
>> - Cortex-A57 big Quad-core
>> - Support PSCI v0.1
>
> [...]
>
>> +       psci {
>> +               compatible = "arm,psci";
>> +               method = "smc";
>> +               cpu_off = <0x84000002>;
>> +               cpu_on = <0xC4000003>;
>> +       };
>
> Back at v2 you mentioned that CPU_OFF wasn't working [1].
>
> Do both CPU_ON and CPU_OFF work for all CPUs, including the boot CPU?

The CPU1 ~ CPU7 are well woking about CPU_ON/OFF.
CPU0 (boot CPU) is only well working for CPU_OFF.
But when I try to turn on the CPU0 after CPU_OFF, I failed it.

>
> I take it CPUs boot at EL2?
>
> [...]
>
>> +               timer {
>> +                       compatible = "arm,armv8-timer";
>> +                       interrupts = <1 13 0xff04>,
>> +                                    <1 14 0xff04>,
>> +                                    <1 11 0xff04>,
>> +                                    <1 10 0xff04>;
>> +               };
>
> The timer node should be moved under the root node. It doesn't live on
> the bus; it's a component of the CPU.

OK. I'll move it according to your comment.

Thanks,
Chanwoo Choi

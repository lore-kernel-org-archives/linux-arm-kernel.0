From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Jan 2018 12:24:02 +0800
Subject: [PATCH v3 0/8] ARM: sun9i: SMP and CPU hotplug support
In-Reply-To: <nycvar.YSQ.7.76.1801151502050.13881@knanqh.ubzr>
References: <20180115071450.18355-1-wens@csie.org>
 <nycvar.YSQ.7.76.1801151502050.13881@knanqh.ubzr>
Message-ID: <CAGb2v66Kn6RDqj7Pjmj_vJ9ivU6PoSiVHdJqHTh9_Q4tUrk+iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 5:00 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 15 Jan 2018, Chen-Yu Tsai wrote:
>
>> Changes since v2:
>>   - Do away with the MCPM framework, directly implement smp_ops
>>   - Some debug messages were clarified
>>   - New ARCH_SUNXI_MCPM Kconfig symbol for this feature
>
> You should use ARCH_SUNXI_SMP instead to avoid confusion with the actual
> MCPM code. Ditto for function names as Dave mentioned.

All switched to "MC_SMP". There is existing, albeit deprecated, SMP code
for single cluster SoCs, so "multi cluster" is desired to differentiate
from the old stuff.

> For the ARM to Thumb switch you could add something like this at the
> beginning of your entry code:
>
> #ifdef CONFIG_THUMB2_KERNEL
>         .arm
>         mov     ip, #1
>         bx      ip
>         .thumb
> #endif
>         [your code follows here]
>
> And make sure that code is word aligned.

Thanks for the tip. As I mentioned in my reply to Dave,
this wasn't really needed.

Thanks again!
ChenYu

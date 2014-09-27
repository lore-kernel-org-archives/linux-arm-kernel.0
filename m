From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Sep 2014 21:16:02 +0800
Subject: [PATCH v2 1/7] ARM: sunxi: Introduce Allwinner A80 support
In-Reply-To: <20140925132527.GF15315@lukather>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-2-git-send-email-wens@csie.org>
 <20140925132527.GF15315@lukather>
Message-ID: <CAGb2v64LwgEZkiuej2KKi+CUU3OkUZaBKJ3ZZn_Y64tDD+LRwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 9:25 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Sep 24, 2014 at 10:48:55PM +0800, Chen-Yu Tsai wrote:
>> The Allwinner A80 is a new Cortex octo-core A7/A15 big.LITTLE SoC.
>> While it's processor cores and interconnecting bus are new, it
>> re-uses many peripherals found in earlier Allwinner SoCs.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/mach-sunxi/Kconfig | 5 +++++
>>  arch/arm/mach-sunxi/sunxi.c | 9 +++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 1aaa1e1..72f222b 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -42,4 +42,9 @@ config MACH_SUN8I
>>       select MFD_SUN6I_PRCM
>>       select RESET_CONTROLLER
>>
>> +config MACH_SUN9I
>> +     bool "Allwinner A80 (sun9i) SoCs support"
>
> With the new naming scheme, I wonder wether it makes sense to have the
> A80 displayed here and in the machine definition.

I expect anything that falls under sun9i to be compatible, or a trimmed
down version. But that's just me.

We know that Allwinner has released the A33, which should be compatible
with the A23, sun8i. And the A83 has been announced, which looks like
a trimmed down version of the A80. The next SoC should be arm64, and
would not matter here.

Kevin, Shuge, could you provide us with the codenames for the A33 and
A83, and what earlier SoC they are based on?


Thanks
ChenYu

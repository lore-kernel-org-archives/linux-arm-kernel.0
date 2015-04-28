From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Tue, 28 Apr 2015 18:25:54 +0900
Subject: ARCH_EXYNOS5433 missing in Kconfig
In-Reply-To: <CAD3Xx4KpTTqNiFA-8EfuPsCR5ow0JkNVo11zM1twkrf8sckJtA@mail.gmail.com>
References: <CAD3Xx4Jf5ACBKe-KvGRD=myHKrJ+K_P0vBrtrmfgh+1zNM4hug@mail.gmail.com>
 <54FF95ED.1040003@samsung.com>
 <CAD3Xx4KpTTqNiFA-8EfuPsCR5ow0JkNVo11zM1twkrf8sckJtA@mail.gmail.com>
Message-ID: <CAGTfZH2yttvRsHXZUXQ7t37wmU=seg8Qoa=h=nat4EwJDY42Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin,


On Mon, Apr 27, 2015 at 3:31 PM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> Hi Chanwoo,
>
> this is a kind reminder that the issue mentioned below is still
> present and made its way to v4.1-rc1.

I sent the patch[1] to fix it. And Sylwester said that he will pick
this patchset on patch[2].
[1] https://lkml.org/lkml/2015/4/27/237
[2] https://lkml.org/lkml/2015/4/28/117

Hi Sylwester,
Could you apply a patch[1] on 4.2-rc2 to fix build warning?

Best Regards,
Chanwoo Choi

>
> Kind regards,
>  Valentin
>
> On Wed, Mar 11, 2015 at 2:10 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Hi Valentin,
>>
>> I sent the Exynos5433 clock patch and then separately I'm sending the
>> Exynos5433 devicetree patch-set[1].
>> [1] [PATCH v6 0/9] arm64: Add the support for new Exynos5433 SoC
>> - https://lkml.org/lkml/2015/3/9/1036
>>
>> But, according to Arnd bergmann's comment[2], latest Exynos5433 dt patch-set[1]
>> removed the CONFIG_ARCH_EXYNOS5433.
>> [2] https://lkml.org/lkml/2015/2/24/85
>>
>>
>> So, I have plan to send following patch.
>>
>> ---
>>     clk: samsung: Use CONFIG_ARCH_EXYNOS instead of Exynos-specific configuration
>>
>>     This patch removes the CONFIG_ARCH_EXYNOS{5433|7} and then use only the
>>     CONFIG_ARCH_EXYNOS for ARM-64bit Exynos SoC.
>>
>>     Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>     Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>     Cc: Arnd Bergmann <arnd@arndb.de>
>>     Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/clk/samsung/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
>> index 17e9af7..561719d 100644
>> --- a/drivers/clk/samsung/Makefile
>> +++ b/drivers/clk/samsung/Makefile
>> @@ -10,11 +10,11 @@ obj-$(CONFIG_SOC_EXYNOS5250)        += clk-exynos5250.o
>>  obj-$(CONFIG_SOC_EXYNOS5260)   += clk-exynos5260.o
>>  obj-$(CONFIG_SOC_EXYNOS5410)   += clk-exynos5410.o
>>  obj-$(CONFIG_SOC_EXYNOS5420)   += clk-exynos5420.o
>> -obj-$(CONFIG_ARCH_EXYNOS5433)  += clk-exynos5433.o
>> +obj-$(CONFIG_ARCH_EXYNOS)      += clk-exynos5433.o
>>  obj-$(CONFIG_SOC_EXYNOS5440)   += clk-exynos5440.o
>>  obj-$(CONFIG_ARCH_EXYNOS)      += clk-exynos-audss.o
>>  obj-$(CONFIG_ARCH_EXYNOS)      += clk-exynos-clkout.o
>>
>>
>> Regards,
>> Chanwoo Choi
>>
>>
>> On 03/11/2015 12:32 AM, Valentin Rothberg wrote:
>>> Hi Chanwoo,
>>>
>>> your commit 96bd6224f07b ("clk: samsung: exynos5433: Add clocks using
>>> common clock framework") is included in today's linux-next tree (i.e.,
>>> next-20150310).
>>>
>>> This patch conditionally compiles clk-exynos5433.c depending on the
>>> Kconfig option ARCH_EXYNOS5433.  However, this option is not defined
>>> in Kconfig, so that the driver cannot be compiled at the current
>>> state:
>>>
>>> +obj-$(CONFIG_ARCH_EXYNOS5433)  += clk-exynos5433.o
>>>
>>> Is there a patch queued somewhere that adds this Kconfig symbol?  I
>>> detected the issue by running undertaker-checkpatch from the
>>> Undertaker tool suite (undertaker.cs.fau.de).  There is also a tool in
>>> the git tree that can detect such issues (i.e.,
>>> scripts/checkkconfigsymbols.py).
>>>
>>> Kind regards,
>>>  Valentin
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

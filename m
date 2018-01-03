From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 3 Jan 2018 18:04:31 +0100
Subject: [GIT PULL 1/3] ARM: dts: exynos: DTS for v4.16
In-Reply-To: <CAK8P3a2wSt5WjT26MT1QhYVxCcYJ8YV0cdsx19zvYZPqUgF+7Q@mail.gmail.com>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-3-krzk@kernel.org>
 <CAK8P3a2wSt5WjT26MT1QhYVxCcYJ8YV0cdsx19zvYZPqUgF+7Q@mail.gmail.com>
Message-ID: <CAJKOXPdhn-BC=pQb9-zMp1yJdiRXYrc=4Pcb+gtf2VmfiyQEiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 10:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>> Krzysztof Kozlowski (2):
>>       ARM: dts: exynos: Add missing interrupt-controller properties to Exynos5410 PMU
>
> I just looked through the remaining warnings in 4.15 and noticed that
> you had sent this
> only for 4.16, not as a bug fix.
>
> Looking closer, it seems incorrect:
>
> According to the comment added to exynos_dt_pmu_match[] in commit
> 8b283c025443 ("ARM: exynos4/5: convert pmu wakeup to stacked domains"),
> the RTC is not able to wake up the system through the PMU on Exynos5410,
> unlike Exynos5420. However, when the RTC DT node got added in commit
> e1e146b1b062 ("ARM: dts: exynos: Add RTC and I2C to Exynos5410"), it was
> a straight copy of the Exynos5420 node, which now causes the warning from dtc,
> and now you add the "interrupt-controller" property to the device node, but
> the code still doesn't handle it at all.

I received a Odroid XU board, based on Exynos5410, from Markus Reichl
(big thanks! it is second board from fivetechno.de) but I did not
setup testing infrastructure on it yet.

I see you pulled my entire DT branch, including the change around
Exynos5410 PMU's interrupts. I think your analysis and your follow-up
patch are correct which means that RTC on Exynso5410 might be broken
now. It is getting late in RC-cycle so I could send a follow-up pull
with fixed DT including your patch [1].

The other way is to drop my commit entirely. I could prepare a rebased
DT branch for this as well.

Let me know if you have any preferences.

Best regards,
Krzysztof

[1] https://patchwork.kernel.org/patch/10128431/

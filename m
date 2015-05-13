From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 12 May 2015 23:17:30 -0400
Subject: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use
 builtin_driver_register
In-Reply-To: <20150512070444.GE32300@linux>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com>
 <20150512070444.GE32300@linux>
Message-ID: <CAP=VYLqNnn1w8ss9to+NGOhwmq8O8wYY9scMg1vQ1+mQmf=Gyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 3:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-05-15, 15:49, Paul Gortmaker wrote:
>> These files depend on Kconfig options all of which are a bool, so
>> we use the appropriate registration function, which avoids us
>> relying on an implicit inclusion of <module.h> which we are
>> doing currently.
>>
>> While this currently works, we really don't want to be including
>> the module.h header in non-modular code, which we'd be forced
>> to do, pending some upcoming code relocation from init.h into
>> module.h.  So we fix it now by using the non-modular equivalent.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: linux-pm at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c  | 2 +-
>
> Exynos can be compiled as a module:
>
> drivers/cpufreq/Kconfig.arm:
>
> config ARM_EXYNOS_CPUFREQ
>         tristate "SAMSUNG EXYNOS CPUfreq Driver"
>         depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250

Sounds like things have changed since I did the original compile
testing ; thanks for the heads-up and I will follow up with the details,
once I can re-test.

Thanks,
Paul.
--

>
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

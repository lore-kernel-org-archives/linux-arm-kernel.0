From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 19:23:02 +0530
Subject: [PATCH v4 8/8] cpufreq: exynos: remove all exynos specific
 cpufreq driver support
In-Reply-To: <20140514092010.02e16520@amdc2363>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-9-git-send-email-thomas.ab@samsung.com>
 <20140514092010.02e16520@amdc2363>
Message-ID: <CAJuA9ajVHivO1AdMDw3Ow=T2yV9QMw2sj0b72SN6a5HftNX5Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Wed, May 14, 2014 at 12:50 PM, Lukasz Majewski
<l.majewski@samsung.com> wrote:
> Hi Thomas,
>
>> -config ARM_EXYNOS_CPU_FREQ_BOOST_SW
>> -     bool "EXYNOS Frequency Overclocking - Software"
>> -     depends on ARM_EXYNOS_CPUFREQ
>> -     select CPU_FREQ_BOOST_SW
>> -     select EXYNOS_THERMAL
>> -     help
>> -       This driver supports software managed overclocking (BOOST).
>> -       It allows usage of special frequencies for Samsung Exynos
>> -       processors if thermal conditions are appropriate.
>> -
>> -       It reguires, for safe operation, thermal framework with
>> properly
>> -       defined trip points.
>> -
>> -       If in doubt, say N.
>> -
>
> If I might ask, where this switch,to enable BOOST, will be moved? All
> in all, I would like to be able to enable boost :-).

The intent was to have a separate boost config option for cpufreq-cpu0
driver, only available if cpufreq-cpu0 driver is selected, as done in
the other patch.

>
> In my opinion we should have the Kconfig option to enable/disable the
> CPU_FREQ_BOOST_SW and this may be used with cpufreq-cpu0 driver as I've
> pointed out in the other patch.

Okay, this is how this patch series handles CPU_FREQ_BOOST_SW config option.

Thanks,
Thomas.


>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
